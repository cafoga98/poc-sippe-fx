import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_sippe_fx/core/network/failure.dart';
import 'package:poc_sippe_fx/core/settings/base_currency_store.dart';
import 'package:poc_sippe_fx/features/currency_list/domain/usecases/get_currency_rates.dart';
import 'package:poc_sippe_fx/features/currency_list/presentation/cubit/currency_list_cubit.dart';
import 'package:poc_sippe_fx/features/currency_list/presentation/cubit/currency_list_state.dart';

class MockGetCurrencyRates extends Mock implements GetCurrencyRates {}

class MockBaseCurrencyStore extends Mock implements BaseCurrencyStore {}

void main() {
  late MockGetCurrencyRates getCurrencyRates;
  late MockBaseCurrencyStore baseCurrencyStore;

  const rows = [
    CurrencyRowData(code: 'USD', name: 'US Dollar', rate: 1.0),
    CurrencyRowData(code: 'EUR', name: 'Euro', rate: 0.92),
  ];

  setUp(() {
    getCurrencyRates = MockGetCurrencyRates();
    baseCurrencyStore = MockBaseCurrencyStore();
    when(() => baseCurrencyStore.read()).thenReturn('USD');
  });

  blocTest<CurrencyListCubit, CurrencyListState>(
    'load(): initial -> loading -> loaded on success',
    build: () {
      when(
        () => getCurrencyRates(baseCode: 'USD'),
      ).thenAnswer((_) async => const Right(rows));
      return CurrencyListCubit(getCurrencyRates, baseCurrencyStore);
    },
    act: (cubit) => cubit.load(),
    expect: () => const [
      CurrencyListState.loading(),
      CurrencyListState.loaded(rows: rows, baseCode: 'USD', searchQuery: ''),
    ],
  );

  blocTest<CurrencyListCubit, CurrencyListState>(
    'load(): initial -> loading -> error on failure with no prior data',
    build: () {
      when(
        () => getCurrencyRates(baseCode: 'USD'),
      ).thenAnswer((_) async => const Left(Failure.network()));
      return CurrencyListCubit(getCurrencyRates, baseCurrencyStore);
    },
    act: (cubit) => cubit.load(),
    expect: () => const [
      CurrencyListState.loading(),
      CurrencyListState.error(failure: Failure.network()),
    ],
  );

  blocTest<CurrencyListCubit, CurrencyListState>(
    'refresh(): loaded -> loading -> staleData when the refresh fails, keeping prior rows',
    build: () {
      when(
        () => getCurrencyRates(baseCode: 'USD'),
      ).thenAnswer((_) async => const Right(rows));
      return CurrencyListCubit(getCurrencyRates, baseCurrencyStore);
    },
    act: (cubit) async {
      await cubit.load();
      when(
        () => getCurrencyRates(baseCode: 'USD'),
      ).thenAnswer((_) async => const Left(Failure.server(500)));
      await cubit.refresh();
    },
    expect: () => const [
      CurrencyListState.loading(),
      CurrencyListState.loaded(rows: rows, baseCode: 'USD', searchQuery: ''),
      CurrencyListState.loading(),
      CurrencyListState.staleData(
        rows: rows,
        baseCode: 'USD',
        searchQuery: '',
        lastFailure: Failure.server(500),
      ),
    ],
  );

  const eurRows = [
    CurrencyRowData(code: 'USD', name: 'US Dollar', rate: 1.09),
    CurrencyRowData(code: 'EUR', name: 'Euro', rate: 1.0),
  ];

  blocTest<CurrencyListCubit, CurrencyListState>(
    'changeBaseCurrency(): loaded -> loading -> loaded with the new base, and BaseCurrencyStore.save is called',
    build: () {
      when(() => baseCurrencyStore.save('EUR')).thenAnswer((_) async {});
      when(
        () => getCurrencyRates(baseCode: 'USD'),
      ).thenAnswer((_) async => const Right(rows));
      when(
        () => getCurrencyRates(baseCode: 'EUR'),
      ).thenAnswer((_) async => const Right(eurRows));
      return CurrencyListCubit(getCurrencyRates, baseCurrencyStore);
    },
    act: (cubit) async {
      await cubit.load();
      await cubit.changeBaseCurrency('EUR');
    },
    expect: () => const [
      CurrencyListState.loading(),
      CurrencyListState.loaded(rows: rows, baseCode: 'USD', searchQuery: ''),
      CurrencyListState.loading(),
      CurrencyListState.loaded(rows: eurRows, baseCode: 'EUR', searchQuery: ''),
    ],
    verify: (_) {
      verify(() => baseCurrencyStore.save('EUR')).called(1);
    },
  );

  blocTest<CurrencyListCubit, CurrencyListState>(
    'changeBaseCurrency(): loaded -> loading -> staleData on failure, keeping the OLD base rows and code '
    '(the displayed rows are still USD-denominated, so the label must not switch to the failed EUR attempt)',
    build: () {
      when(() => baseCurrencyStore.save('EUR')).thenAnswer((_) async {});
      when(
        () => getCurrencyRates(baseCode: 'USD'),
      ).thenAnswer((_) async => const Right(rows));
      when(
        () => getCurrencyRates(baseCode: 'EUR'),
      ).thenAnswer((_) async => const Left(Failure.network()));
      return CurrencyListCubit(getCurrencyRates, baseCurrencyStore);
    },
    act: (cubit) async {
      await cubit.load();
      await cubit.changeBaseCurrency('EUR');
    },
    expect: () => const [
      CurrencyListState.loading(),
      CurrencyListState.loaded(rows: rows, baseCode: 'USD', searchQuery: ''),
      CurrencyListState.loading(),
      CurrencyListState.staleData(
        rows: rows,
        baseCode: 'USD',
        searchQuery: '',
        lastFailure: Failure.network(),
      ),
    ],
  );

  blocTest<CurrencyListCubit, CurrencyListState>(
    'changeBaseCurrency(): initial -> loading -> error when there is no prior data to fall back on',
    build: () {
      when(() => baseCurrencyStore.save('EUR')).thenAnswer((_) async {});
      when(
        () => getCurrencyRates(baseCode: 'EUR'),
      ).thenAnswer((_) async => const Left(Failure.network()));
      return CurrencyListCubit(getCurrencyRates, baseCurrencyStore);
    },
    act: (cubit) => cubit.changeBaseCurrency('EUR'),
    expect: () => const [
      CurrencyListState.loading(),
      CurrencyListState.error(failure: Failure.network()),
    ],
  );
}
