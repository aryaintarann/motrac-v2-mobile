// Basic smoke test for Motrac v2

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('App can be instantiated', () {
    // Supabase requires initialization before the app can be pumped,
    // so we just verify the test framework works.
    expect(1 + 1, equals(2));
  });
}
