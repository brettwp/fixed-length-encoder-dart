# fixed_length_encoder_dart

A one-to-one mapping function between integers and fixed length strings, such that sequential
integers are mapped to non-sequential strings.  In other words you can obfuscate user ids for use
in urls.

* ~https://rubygems.org/gems/fixed_length_encoder~  (Update this to Dart package location)
* http://github.com/brettwp/fixed_length_encoder_dart

> **NOTE:** The documentation below is copied fromt he Javascript version which was copied from the Ruby version.
> Usage may not be correct for all examples.  Refer to the `lib` or `test` files for better examples.
> Hopefully this will be cleaned up soon. [Last updated 2019/10/06]

## How it works

### Encoding

Converts an integer value to a string of fixed length (default is 8).  As of ~version `1.2`~ the maximum encodable value is the same as the alphabet maximum.  For example the default 36 character alphabet and 8 character fixed length can encoded numbers between 0 and 2,821,109,907,455 = `pow(36, 8) - 1`.

### Decoding

Given a valid string returns the decoded number.  Note that the two operations are reversible and
adjacent values are unlikely to return adjacent strings (See [Stats](#stats) section below).  For example, using the default configuration:

```dart
encoder = FixedLengthEncoder();
encoder.decode(encoder.encode(100)) == 100
encoder.encode(100) == 'ycxk2ntw'
encoder.encode(101) == 'd8gxk24x'
```

## How to install

[Install instructions for Dart package unavailable]

## How to use

> This needs fixing after fle is published as a package!!!

```dart
import 'package:fixed_length_encoder/fixed_length_encoder.dart';
```

## Changing the length

```dart
encoder = FixedLengthEncoder();
encoder.messageLength = 10;
```

## Changing the alphabet and encoding

The `alphabet`, `encodeMap` and `decodeMap` must all work together.  The two maps must also be
reversible.  For example, for an alphabet of 62 characters you will need to build two maps of
length `62 * 62` such that `decodeMap[encodeMap[x]] == x`.  One such way to do this would be:

```dart
alphabet = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
var mapLength = 62 * 62;
decodeMap = List<int>(mapLength);
encodeMap = List.generate(mapLength, (i) => i)..shuffle();
encodeMap.asMap().forEach((i, v) => encoder.decodeMap[v] = i);
```

Then, hard code these results into your application.  You will have three lines much like the lines
that define the default `alphabet`, `encodeMap` and `decodeMap` in the `FixedLengthEncoded`:

```dart
encoder.alphabet = 'abcdefg';
encoder.encodeMap = [19, 22, 25, 44, 17, 21, 33, 48, 39, 0, 16, 20, 29, 40, 43, 23, 3, 41, 12, 35, 7, 14, 10, 32, 46, 38, 9, 11, 27, 31, 26, 18, 34, 24, 4, 42, 47, 5, 1, 36, 13, 37, 30, 15, 45, 2, 8, 28, 6];
encoder.decodeMap = [9, 38, 45, 16, 34, 37, 48, 20, 46, 26, 22, 27, 18, 40, 21, 43, 10, 4, 31, 0, 11, 5, 1, 15, 33, 2, 30, 28, 47, 12, 42, 29, 23, 6, 32, 19, 39, 41, 25, 8, 13, 17, 35, 14, 3, 44, 24, 36, 7];
```

# Stats

Consider a random `value` using the `FixedLengthEncoder` default `messageLength` of 8 and `alphabet` of 36
characters.  If we encode `value` and `value + 1` and compute the difference between them in base 36
we get a `delta`.  The table below compares the distribution of 10M pairs of two adjacent encoded values with 10M pairs of two random numbers.
Both sets are taken from the range `0` to `pow(36, 8) = 2,821,109,907,456`.  As expected the number of
negative deltas is near `50%`.  For the encoded values `49.9860%` and for the random values `49.9989%` negative deltas.
It's interesting to note that there are no random occurances of two adjecent values, but in the
encoded values there are `674`.

|                 | Encoded           | Random            |
| ---------------:| -----------------:| -----------------:|
|  Negative deltas|         4,998,610 |         4,999,894 |
| Delta equals one|               674 |                 0 |
|    Maximum Delta| 2,820,278,456,877 | 2,820,579,691,973 |
|    Average Delta|   935,745,508,922 |   940,183,477,180 |
|          Std Dev| 1,148,460,034,903 | 1,151,442,250,985 |


* Author  :: Brett Pontarelli <brett@paperyfrog.com>
* Website :: http://brett.pontarelli.com
