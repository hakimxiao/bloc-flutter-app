import 'package:flutter_test/flutter_test.dart';
import 'package:blog_app/utils/math_utils.dart';

void main() {
  test('Test fungsi tambah', () {
    final hasil = tambah(2, 3);
    expect(hasil, 5);
  });
}
