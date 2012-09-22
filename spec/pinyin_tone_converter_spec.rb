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

require_relative '../pinyin_tone_converter'

describe 'pinyin_tone_converter tests' do
  context 'basic tests' do
    context 'numbered pinyin to utf-8' do
      def self.basic_test(a, b)
        it "#{a} should convert to #{b}" do
          b.should == PinyinToneConverter.number_to_utf8( a )
        end
      end

      # Empty string
      basic_test("", "")
      basic_test(" ", "")

      # All four tones
      basic_test("zhong1", "zhōng")
      basic_test("zhong1 wen2", "zhōng wén")
      basic_test("wang3 xing4", "wǎng xìng")
      basic_test("zhong1 wen2 wang3 xing4", "zhōng wén wǎng xìng")

      # Handling 'er'
      basic_test("er1 er2 er3 er4", "ēr ér ěr èr")

      # Handling repositioning for 'i'
      basic_test("liang1 bai2", "liāng bái")

      # Handling repositioning for 'ü'
      basic_test("lüe3 wün4", "lüě wǜn")

      # Also Handling v
      basic_test("lve3 wvn4", "lüě wǜn")

      # Also Handling u:
      basic_test("lu:e3 wu:n4", "lüě wǜn")

      # Zero tone tests
      basic_test("shuo1 le0", "shūo le")
      basic_test("shuo0 shou3", "shuo shǒu")
      basic_test("shuo", "shuo")
      basic_test("shuo0", "shuo")

      # Extra white space
      basic_test("zhong1   wen2  ", "zhōng wén")

      # No white space
      basic_test("zhong1wen2", "zhōng wén")

      # Other characters
      basic_test("zhong1!@$%^&**wen2", "zhōng wén")

      # Unexpected/bogus input
      # We don't actually care so much what it does, so just sanity checking
      basic_test("zhng1 2", "zhng")
      basic_test("zhōng wén", "zh ng w n")
      basic_test("123", "")
      basic_test("1 2 3", "")
    end

    context 'utf-8 pinyin to numbered' do
      def self.basic_test(a, b)
        it "#{a} should convert to #{b}" do
          b.should == PinyinToneConverter.utf8_to_number( a )
        end
      end

      # Empty string
      basic_test("", "")
      basic_test(" ", "")

      # All four tones
      basic_test("zhōng", "zhong1")
      basic_test("zhōng wén", "zhong1 wen2")
      basic_test("wǎng xìng", "wang3 xing4")
      basic_test("zhōng wén wǎng xìng", "zhong1 wen2 wang3 xing4")

      # Handling 'er'
      basic_test("ēr ér ěr èr", "er1 er2 er3 er4")

      # When tone is on "wrong" syllable
      basic_test("lìang baì", "liang4 bai4")
      basic_test("lǜe wǜn", "lve4 wvn4")
      basic_test("shoū le", "shou1 le")

      # Zero tone tests
      basic_test("shūo le", "shuo1 le")
      basic_test("shuo shǒu", "shuo shou3")
      basic_test("shuo", "shuo")

      # Extra white space
      basic_test("zhōng   wén  ", "zhong1 wen2")

      # Other characters
      basic_test("zhōng!@$%^&**wén", "zhong1 wen2")

      # Unexpected/bogus input
      # We don't actually care so much what it does, so just sanity checking
      basic_test("zhng1 2", "zhng")
      basic_test("zh ng w n", "zh ng w n")
      basic_test("zhong1 wen2", "zhong wen")
      basic_test("123", "")
      basic_test("1 2 3", "")
      basic_test("shuo0", "shuo")
      basic_test("zhōngwén", "zhongwen2")
      basic_test("lìāng báì", "liang1 bai4")
      basic_test("lǜě wǜn", "lve3 wvn4")
    end
  end

  context 'interating over all syllables' do
    def self.initials
      ['b', 'p', 'm', 'f', 'd', 't', 'n', 'l', 'g', 'k', 'h', 'j',
       'q', 'x', 'z', 'c', 's', 'zh', 'ch', 'sh', 'r', '']
    end

    def self.finals
      ['a', 'e', 'i', 'o', 'u', 'v', 'u:', 'ü', 'ai', 'ei', 'ao', 'ou',
       'an', 'en', 'ang', 'eng', 'ong', 'ia', 'iao', 'ie', 'iu', 'ian',
       'in', 'iang', 'ing', 'iong', 'ua', 'uo', 'uai', 'ui', 'uan', 'un',
       'uang', 'ueng', 've', 'u:e', 'üe', 'van', 'u:an', 'üan', 'vn',
       'u:n', 'ün']
    end

    def self.all_syllables
      rc = []
      initials.each do |c|
        finals.each do |v|
          if ( c == '' )
            if ( v == 'u' )
              rc.push( 'wu' )
            elsif ( v == 'un' )
              rc.push( 'wun' )
            elsif ( v[0,2] == 'u:' )
              rc.push( 'yu' + v[2..-1] )
            elsif ( v[0] == 'v' || v[0] == 'ü' )
              rc.push( 'yu' + v[1..-1] )
            elsif ( v[0] == 'u' )
              rc.push( 'w' + v[1..-1] )
            elsif ( v == 'in' || v == 'ing' || v == 'i' )
              rc.push( 'y' + v )
            elsif ( v[0] == 'i' )
              rc.push( 'y' + v[1..-1] )
            else
              rc.push( v )
            end
          else
            if ( v == 'ueng' )
              v = 'ong'
            end
            rc.push( c + v )
          end
        end
      end
      rc.push( 'er' ).uniq
    end

    all_syllables.each do |syllable|
      it "converting #{syllable} and back" do
        set = []
        1.upto(4) do |tone|
          set.push( syllable + tone.to_s )
        end
        string = set.join(" ")
        converted = PinyinToneConverter.number_to_utf8( string )
        string = string.gsub(/ü/, 'v').gsub(/u\:/, 'v')
        string.should == PinyinToneConverter.utf8_to_number( converted )
      end
    end
  end
end
