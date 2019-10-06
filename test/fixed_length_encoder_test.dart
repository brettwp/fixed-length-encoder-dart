import 'package:flutter_test/flutter_test.dart';
import 'package:fixed_length_encoder/fixed_length_encoder.dart';
import 'dart:math' as math;

void main() {
  FixedLengthEncoder encoder;

  setUp(() {
    encoder = FixedLengthEncoder();
    encoder.alphabet = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var mapLength = 62 * 62;
    encoder.decodeMap = List<int>(mapLength);
    encoder.encodeMap = List.generate(mapLength, (i) => i)..shuffle();
    encoder.encodeMap.asMap().forEach((i, v) => encoder.decodeMap[v] = i);
  });

  group('validation and getters', () {
    test('in/valid alphabet', () {
      expect(encoder.isValidAlphabet(), true);
      encoder.alphabet = 'abcddd';
      expect(encoder.isValidAlphabet(), false);
    });

    test('in/valid mappings', () {
      expect(encoder.isValidMap(), true);
      encoder.decodeMap = encoder.encodeMap;
      expect(encoder.isValidMap(), false);
    });

    test('max value', () {
      var max = math.pow(62, 10) - 1;
      encoder.messageLength = 10;
      expect(encoder.maxValue, max);
    });
  });

  group('values and messages', () {
    test('shouldn\'t encode negative values', () {
      expect(() => encoder.encode(-1), throwsArgumentError);
    });

    test('shouldn\'t encode values too big for message length', () {
      encoder.messageLength = 2;
      var maxPlusOne = math.pow(62, 2);
      expect(() => encoder.encode(maxPlusOne), throwsArgumentError);
    });

    test('should error for bad characters', () {
      expect(() => encoder.decode('^'), throwsArgumentError);
    });
  });

  group('encode/decode', () {
    test('reversible for the min value', () {
      var value = 0;
      var message = encoder.encode(value);
      expect(encoder.decode(message), value);
    });

    test('reversible for the max value', () {
      var value = encoder.maxValue;
      var message = encoder.encode(value);
      expect(encoder.decode(message), value);
    });

    test('reversible for the middle value', () {
      var value = (encoder.maxValue / 2).floor();
      var message = encoder.encode(value);
      expect(encoder.decode(message), value);
    });
  });

  group('default encodings', () {
    setUp(() {
      encoder = FixedLengthEncoder();
    });

    test('reversible for the min value', () {
      var value = 0;
      var message = encoder.encode(value);
      expect(encoder.decode(message), value);
    });

    test('reversible for the max value', () {
      var value = encoder.maxValue;
      var message = encoder.encode(value);
      expect(encoder.decode(message), value);
    });

    test('reversible for the middle value', () {
      var value = (encoder.maxValue / 2).floor();
      var message = encoder.encode(value);
      expect(encoder.decode(message), value);
    });
  });
}
