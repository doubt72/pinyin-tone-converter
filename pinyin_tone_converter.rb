# -*- coding: utf-8 -*-
# Copyright 2012 Douglas Triggs (douglas@triggs.org), All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you
# may not use this file except in compliance with the License. You may
# obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied. See the License for the specific language governing
# permissions and limitations under the License.

class PinyinToneConverter
  @@conversion_list = [['a', 'e', 'i', 'o', 'u', 'ü'],
                       ['ā', 'ē', 'ī', 'ō', 'ū', 'ǖ'],
                       ['á', 'é', 'í', 'ó', 'ú', 'ǘ'],
                       ['ǎ', 'ě', 'ǐ', 'ǒ', 'ǔ', 'ǚ'],
                       ['à', 'è', 'ì', 'ò', 'ù', 'ǜ']]
  @@preferred_vowels = ['a', 'e', 'o', 'u']
  @@all_vowels = ['ā', 'ē', 'ī', 'ō', 'ū', 'ǖ',
                  'á', 'é', 'í', 'ó', 'ú', 'ǘ',
                  'ǎ', 'ě', 'ǐ', 'ǒ', 'ǔ', 'ǚ',
                  'à', 'è', 'ì', 'ò', 'ù', 'ǜ']


  def self.number_to_utf8( string )
    # Convert a numbered pinyin string (e.g., "zhong1 wen2") to UTF-8
    # equivalent with diacriticals ("zhōng wén").  Syllables must be
    # delimited by numbers, spaces, or some non-alphabetic character
    # (which will be otherwise ignored)

    string = string.downcase
    syllable = ""
    utf8 = ""
    string.each_char do |char|
      if ( char == 'v' )
        syllable += 'ü'
      elsif ( (char >= 'a' && char <= 'z') || char == 'ü')
        syllable += char
      elsif ( char == ':' )
        if ( syllable[-1] == 'u' )
          syllable[-1] = 'ü'
        end
      elsif ( char >= '1' && char <= '4' )
        tone = char.to_i
        # Tone marker should go on first vowel that's not i or ü;
        # only use i or ü when that's the only vowel available
        mark = nil
        0.upto( syllable.length - 1 ) do |index|
          if ( @@preferred_vowels.include?( syllable[index] ) )
            mark = index
            break
          elsif ( @@conversion_list[0].include?( syllable[index] ) )
            mark = index
          end
        end
        if (mark)
          index = @@conversion_list[0].index( syllable[mark] )
          syllable[mark] = @@conversion_list[tone][index]
        end
        utf8 += syllable
        if (syllable.length > 0)
          utf8 += " "
        end
        syllable = ""
      else
        # All other chars -- spaces, anything -- break syllables, but
        # otherwise ignored
        utf8 += syllable
        if (syllable.length > 0)
          utf8 += " "
        end
        syllable = ""
      end
    end
    utf8 += syllable
    utf8.rstrip
  end

  def self.utf8_to_number( string )
    # Convert a UTF-8 pinyin string with tone diacriticals (e.g.,
    # "zhōng wén") to an ASCII numbered pinyin string equivalent
    # ("zhong1 wen2").  Syllables must be delimted by some
    # non-alphabetic character, which will be otherwise ignored

    string = string.downcase
    syllable = ""
    pinyin = ""
    tone = 0
    string.each_char do |char|
      if ( char >= 'a' && char <= 'z' )
        syllable += char
      elsif (char == 'ü')
        syllable += 'v'
      elsif ( @@all_vowels.include?(char) )
        1.upto(4) do |x|
          if ( @@conversion_list[x].include?(char) )
            index = @@conversion_list[x].index(char)
            new = @@conversion_list[0][index]
            if (new == 'ü')
              new = 'v'
            end
            syllable += new
            tone = x
          end
        end
      else
        pinyin += syllable
        if (tone > 0)
          pinyin += tone.to_s
          tone = 0
        end
        if (syllable.length > 0)
          pinyin += " "
        end
        syllable = ""
      end
    end
    pinyin += syllable
    if (tone > 0)
      pinyin += tone.to_s
      tone = 0
    end
    pinyin.rstrip
  end
end
