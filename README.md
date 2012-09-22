# Pinyin Tone Converter

This repository contains a simple ruby class (PinyinToneConverter) that converts pinyin numbered tones (i.e., something like "zhong1 wen2") to the pinyin UTF-8 equivalent with tone diacritical marks (like "zhōng wén") and back.

## Usage

[TODO: Docs on wrapper script]

### Class Methods

        number_to_utf8(string)
Convert pinyin numbered tones ("zhong1 wen2") to pinyin UTF-8 equivalent with diacritical marks ("zhōng wén").

        utf8_to_number(string)
Convert pinyin marked with UTF-8 diacritical tone markers ("zhōng wén") to ASCII numbered tone equivalents ("zhong1 wen2").

### Notes

* Any of the various standard forms of ü are supported for input (ü or u: or v) and produce double-diacritic forms of the characters for tones (ǖ, ǘ, ǚ, ǜ).  ASCII output will produce the 'v' character, so as to avoid all UTF-8 diacriticals in output.

* Whenever possible, putting diactrical marks on i or ü will be avoided; generally the mark will be added to the first vowel that is not i or ü, but it will fall back to marking those vowels if they're the only vowel available.

* Syllables must be separated by some non-alphabetic character; this can be anything (but would typically be spaces), including the numeric tone markers themselves.

## Tests

Also, tests to make sure it works.  Because everybody likes well-tested code.

[TODO: Docs on running tests go here]

## License

Copyright 2012 Douglas Triggs (douglas@triggs.org), All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
