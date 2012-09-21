# Pinyin Tone Converter

This repository contains a simple ruby class (PinyinToneConverter) that converts pinyin numbered tones (i.e., something like "zhong1 wen2") to the UTF-8 equivalent with tone diacritical marks (like "zhōngwén") and back.

## Usage

[TODO: Docs on wrapper script]

### Class Methods

<number_to_utf8(string)>

Converts pinyin numbered tones ("zhong1 wen2") to UTF-8 equivalent with diacritical marks ("zhōngwén").

<utf8_to_number(string)>

Converts pinyin marked with UTF-8 diacritical tone markers ("zhōngwén") to ASCII numbered tone equivalents ("zhong1 wen2").

### Notes

* The class should support any of the various standard forms of ü for input (ü or u: or v) and produce double-diacritic forms of those characters for tones (ǖ, ǘ, ǚ, ǜ).

## Tests

Also, tests to make sure it works.  Because everybody likes well-tested code.

[TODO: Docs on running tests go here]

## License

Copyright 2012 Douglas Triggs (douglas@triggs.org), All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
