import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_sippe_fx/core/network/failure.dart';
import 'package:poc_sippe_fx/features/currency_detail/presentation/cubit/currency_detail_cubit.dart';
import 'package:poc_sippe_fx/features/currency_detail/presentation/cubit/currency_detail_state.dart';
import 'package:poc_sippe_fx/features/currency_detail/presentation/pages/currency_detail_page.dart';

class MockCurrencyDetailCubit extends MockCubit<CurrencyDetailState>
    implements CurrencyDetailCubit {}

void main() {
  late MockCurrencyDetailCubit cubit;

  setUp(() {
    cubit = MockCurrencyDetailCubit();
  });

  Widget wrap(Widget child) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: '/detail',
        routes: [
          GoRoute(
            path: '/detail',
            builder: (context, state) =>
                BlocProvider<CurrencyDetailCubit>.value(
                  value: cubit,
                  child: child,
                ),
          ),
        ],
      ),
    );
  }

  testWidgets('loading state renders a progress indicator', (tester) async {
    when(() => cubit.state).thenReturn(const CurrencyDetailState.loading());

    await tester.pumpWidget(
      wrap(const CurrencyDetailPage(baseCode: 'USD', quoteCode: 'PEN')),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Reintentar'), findsNothing);
  });

  testWidgets(
    'error state renders the failure message and a retry button that calls refresh()',
    (tester) async {
      when(
        () => cubit.state,
      ).thenReturn(const CurrencyDetailState.error(failure: Failure.network()));
      when(() => cubit.refresh()).thenAnswer((_) async {});

      await tester.pumpWidget(
        wrap(const CurrencyDetailPage(baseCode: 'USD', quoteCode: 'PEN')),
      );

      expect(find.text(const Failure.network().message), findsOneWidget);
      final retryButtonFinder = find.text('Reintentar');
      expect(retryButtonFinder, findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await tester.tap(retryButtonFinder);
      await tester.pump();

      verify(() => cubit.refresh()).called(1);
    },
  );
}
