import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import 'package:fixed_length_encoder/encoder_config.dart';

List shuffle(List l) {
  var random = math.Random();
  for (var i = 0; i < l.length; i++) {
    var r = random.nextInt(i + 1);
    var t = l[i];
    l[i] = l[r];
    l[r] = t;
  }
  return l;
}

void main() {
    var config;

    setUp(() {
      config = EncoderConfig();
      config.alphabet = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
      var length = 62 * 62;
      config.decodeMap = List<int>(length);
      config.encodeMap = List.generate(length, (i) => i)..shuffle();
      config.encodeMap.asMap().forEach((i, v) => config.decodeMap[v] = i);
    });

    test('in/valid alphabet', () {
      expect(config.isValidAlphabet(), true);
      config.alphabet = 'abcddd';
      expect(config.isValidAlphabet(), false);
    });

    test('in/valid mappings', () {
      expect(config.isValidMap(), true);
      config.decodeMap = config.encodeMap;
      expect(config.isValidMap(), false);
    });

    test('invalid length', () {
      config.length = 0;
      expect(config.isValid(), false);
      config.length = -2;
      expect(config.isValid(), false);
    });

    test('max value', () {
      var max = math.pow(62, 10);
      config.length = 10;
      expect(config.maxValue, max);
    });
}
