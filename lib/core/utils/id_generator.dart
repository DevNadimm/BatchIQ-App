import 'dart:math';

String generateDocId(String prefix) {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final Random random = Random();

  String randomString = List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();

  return '$prefix$randomString';
}
