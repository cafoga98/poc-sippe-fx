import 'package:flutter_test/flutter_test.dart';
import 'package:poc_sippe_fx/main.dart';

void main() {
  test('MyApp is constructible', () {
    // A full pumpWidget() smoke test would need DI/Hive bootstrapped and would
    // trigger a real network call via the initial /list route (main.dart wires
    // getIt<CurrencyListCubit>()..load() into go_router) — CurrencyListPage's
    // own widget test (with a mocked cubit) already covers the UI states.
    expect(() => const MyApp(), returnsNormally);
  });
}
