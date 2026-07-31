import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_sippe_fx/core/network/failure.dart';
import 'package:poc_sippe_fx/features/currency_list/domain/usecases/get_currency_rates.dart';
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

  testWidgets(
    'selecting a new base currency from the picker shows loading then rows for the new base, '
    'with no stale-base rows left on screen mid-transition',
    (tester) async {
      const oldRows = [
        CurrencyRowData(code: 'USD', name: 'US Dollar', rate: 1.0),
        CurrencyRowData(code: 'EUR', name: 'Euro', rate: 0.92),
      ];
      const newRows = [
        CurrencyRowData(code: 'USD', name: 'US Dollar', rate: 1.09),
        CurrencyRowData(code: 'EUR', name: 'Euro', rate: 1.0),
      ];
      const loadedUsd = CurrencyListState.loaded(
        rows: oldRows,
        baseCode: 'USD',
        searchQuery: '',
      );
      const loadingState = CurrencyListState.loading();
      const loadedEur = CurrencyListState.loaded(
        rows: newRows,
        baseCode: 'EUR',
        searchQuery: '',
      );

      // 1) Selecting a currency from the picker calls changeBaseCurrency
      // with its code.
      when(() => cubit.state).thenReturn(loadedUsd);
      when(() => cubit.changeBaseCurrency('EUR')).thenAnswer((_) async {});

      await tester.pumpWidget(wrap(const CurrencyListPage()));

      expect(find.text('Moneda base: USD'), findsOneWidget);

      await tester.tap(find.text('Moneda base: USD'));
      await tester.pumpAndSettle();

      await tester.tap(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.text('EUR'),
        ),
      );
      await tester.pumpAndSettle();

      verify(() => cubit.changeBaseCurrency('EUR')).called(1);

      // 2) While the cubit is mid-transition (loading), no old-base rows are
      // left on screen. `BlocBuilder` only re-reads `cubit.state` on mount
      // (it otherwise tracks `cubit.stream`), so force a full unmount before
      // re-pumping with the new stub, rather than updating the existing tree.
      await tester.pumpWidget(const SizedBox());
      when(() => cubit.state).thenReturn(loadingState);
      await tester.pumpWidget(wrap(const CurrencyListPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
      expect(find.textContaining('USD'), findsNothing);

      // 3) Once loaded, rows reflect the new base.
      await tester.pumpWidget(const SizedBox());
      when(() => cubit.state).thenReturn(loadedEur);
      await tester.pumpWidget(wrap(const CurrencyListPage()));

      expect(find.text('Moneda base: EUR'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    },
  );
}
