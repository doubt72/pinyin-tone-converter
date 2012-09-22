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

require_relative 'pinyin_tone_converter'
require 'csv'

filename = ARGV[0]
column = ARGV[1].to_i

CSV.open(filename + ".out", "wb") do |csv|
  CSV.foreach(filename) do |row|
    row[column] = PinyinToneConverter.number_to_utf8(row[column])
    csv << row
  end
end

