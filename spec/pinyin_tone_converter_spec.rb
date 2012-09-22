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

  # TODO: for single syllables, 0-syllables, v-syllables
end
