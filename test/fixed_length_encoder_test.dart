import 'package:flutter_test/flutter_test.dart';

import 'package:fixed_length_encoder/fixed_length_encoder.dart';

void main() {
  FixedLengthEncoder encoder;

  setUp(() {
    encoder = FixedLengthEncoder();
  });

  test('reversible for the min value', () {
    var value = 0;
    var message = encoder.encode(value);
    expect(encoder.decode(message)).toEqual(value);
  });

//     it('should be reversible for the min value', () => {
//       var value = 0;
//       var message = fle.encode(value);
//       expect(fle.decode(message)).toEqual(value);
//     });

//     it('should be reversible for the max value', () => {
//       value = Math.pow(62, 8) - 1;
//       message = fle.encode(value);
//       expect(fle.decode(message)).toEqual(value);
//     });

//     it('should be reversible for the middle value', () => {
//       value = Math.pow(62, 8) - 1;
//       value = Math.floor(value / 2);
//       message = fle.encode(value);
//       expect(fle.decode(message)).toEqual(value);
//     });

//     it('should be reversible for the min value', () => {
//       var value = 0;
//       var message = fle.encode(value);
//       expect(fle.decode(message)).toEqual(value);
//     });

//     it('should be reversible for the max value', () => {
//       value = Math.pow(62, 8) - 1;
//       message = fle.encode(value);
//       expect(fle.decode(message)).toEqual(value);
//     });

//     it('should be reversible for the middle value', () => {
//       value = Math.pow(62, 8) - 1;
//       value = Math.floor(value / 2);
//       message = fle.encode(value);
//       expect(fle.decode(message)).toEqual(value);
//     });
}
