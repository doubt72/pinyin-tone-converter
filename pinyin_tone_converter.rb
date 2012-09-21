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
  @@conversion_list =
    [['a', 'e', 'i', 'o', 'u', 'ü'],
     ['ā', 'ē', 'ī', 'ō', 'ū', 'ǖ'],
     ['á', 'é', 'í', 'ó', 'ú', 'ǘ'],
     ['ǎ', 'ě', 'ǐ', 'ǒ', 'ǔ', 'ǚ'],
     ['à', 'è', 'ì', 'ò', 'ù', 'ǜ']]
  @@preferred_characters = ['a', 'e', 'o', 'u']

  def self.number_to_utf8( string )
    # Convert a numbered pinyin string (e.g., "zhong1 wen2") to UTF-8
    # equivalent with diacriticals ("zhōngwén").

    string = string.downcase
    syllable = ""
    utf8 = ""
    string.each_char do |char|
      if ( char == 'v' )
        syllable += 'ü'
      elsif ( char >= 'a' && char <= 'z' )
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
          if ( @@preferred_characters.include?( syllable[index] ) )
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
        syllable = ""
      else
        # All other chars -- spaces, anything -- break syllables, but
        # otherwise ignored
        utf8 += syllable
        syllable = ""
      end
    end
    utf8 += syllable
  end

  def self.utf8_to_number( string )
    # Convert a UTF-8 pinyin string with tone diacriticals (e.g.,
    # "zhōngwén") to an ASCII numbered pinyin string equivalent
    # ("zhong1 wen2")

    # TODO: actually do it
  end
end
