import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_sippe_fx/core/network/failure.dart';
import 'package:poc_sippe_fx/features/currency_list/presentation/cubit/currency_list_cubit.dart';
import 'package:poc_sippe_fx/features/currency_list/presentation/cubit/currency_list_state.dart';
import 'package:poc_sippe_fx/features/currency_list/presentation/pages/currency_list_page.dart';

class MockCurrencyListCubit extends MockCubit<CurrencyListState>
    implements CurrencyListCubit {}

void main() {
  late MockCurrencyListCubit cubit;

  setUp(() {
    cubit = MockCurrencyListCubit();
  });

  Widget wrap(Widget child) {
    return MaterialApp(
      home: BlocProvider<CurrencyListCubit>.value(value: cubit, child: child),
    );
  }

  testWidgets(
    'loading state renders a progress indicator and no list or error',
    (tester) async {
      when(() => cubit.state).thenReturn(const CurrencyListState.loading());

      await tester.pumpWidget(wrap(const CurrencyListPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
      expect(find.text('Reintentar'), findsNothing);
    },
  );

  testWidgets(
    'error state renders the failure message and a retry button that calls refresh()',
    (tester) async {
      when(
        () => cubit.state,
      ).thenReturn(const CurrencyListState.error(failure: Failure.network()));
      when(() => cubit.refresh()).thenAnswer((_) async {});

      await tester.pumpWidget(wrap(const CurrencyListPage()));

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
