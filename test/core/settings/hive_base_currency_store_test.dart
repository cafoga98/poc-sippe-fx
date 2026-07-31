import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:poc_sippe_fx/core/settings/hive_base_currency_store.dart';

void main() {
  late Directory tempDir;
  late Box<String> box;
  late HiveBaseCurrencyStore store;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp(
      'hive_base_currency_store_test',
    );
    Hive.init(tempDir.path);
    box = await Hive.openBox<String>(appSettingsBoxName);
    store = HiveBaseCurrencyStore(box);
  });

  tearDown(() async {
    await box.deleteFromDisk();
    await tempDir.delete(recursive: true);
  });

  test('defaults to USD when the box is empty', () {
    expect(store.read(), 'USD');
  });

  test('save then read round-trips the persisted value', () async {
    await store.save('EUR');

    expect(store.read(), 'EUR');
  });

  test('save overwrites a previously persisted value', () async {
    await store.save('EUR');
    await store.save('JPY');

    expect(store.read(), 'JPY');
  });
}
