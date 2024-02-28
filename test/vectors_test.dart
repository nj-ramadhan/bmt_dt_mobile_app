import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:bmt_dt_mobile_app/resources/resources.dart';

void main() {
  test('vectors assets test', () {
    expect(File(Vectors.facebook).existsSync(), isTrue);
    expect(File(Vectors.google).existsSync(), isTrue);
    expect(File(Vectors.fingerprint).existsSync(), isTrue);
  });
}
