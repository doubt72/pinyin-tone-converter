# Pinyin Tone Converter

Wherein I solve a problem nobody really has (^_^), this repository contains a simple ruby class (PinyinToneConverter) that converts pinyin numbered tones (i.e., something like "zhong1 wen2") to the UTF-8 equivalent pinyin using tone diacritical marks (like "zhōng wén") and back.

## Usage

### Class Methods

        number_to_utf8(string)
Convert pinyin numbered tones ("zhong1 wen2") to UTF-8 equivalent with diacritical marks ("zhōng wén").

        utf8_to_number(string)
Convert pinyin marked with UTF-8 diacritical tone markers ("zhōng wén") to ASCII numbered tone equivalents ("zhong1 wen2").

### CSV Conversion Script

Included is a fairly rudimentary script for converting a field in a CSV file:

        ruby convert_csv.rb <filename> <column>

Where filename is the input filename (the output filename will have ".out" appended to the end) and column is the column number (counting from zero, of course).

### Notes

* Any of the various standard forms of ü are supported for input (ü or u: or v) and produce double-diacritic forms of the characters for tones (ǖ, ǘ, ǚ, ǜ).  ASCII output will produce the 'v' character, so as to avoid all UTF-8 diacriticals in output.

* Whenever possible, putting diactrical marks on i or ü will be avoided; generally the mark will be added to the first vowel that is not i or ü, but it will fall back to marking those vowels if they're the only vowel available.

* Syllables must be separated by some non-alphabetic character; this can be anything (but would typically be spaces), including the numeric tone markers themselves.

## Tests

This repository includes tests to make sure it works (because everybody likes well-tested code).  Tests can be run by simply running the rspec command in the main repository directory:

        rspec

Easy peasy.  Only 963 tests at last count -- obviously the test suite still needs some beefing up. ^_^

(Rspec is required to run the tests, so you'll need to install that.)

## License

Copyright 2012 Douglas Triggs (douglas@triggs.org), All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
