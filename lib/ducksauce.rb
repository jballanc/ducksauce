# Copyright (c) 2012, Joshua Ballanco.
# All rights reserved.
#
# This file is covered by the BSD 2-Clause License.
# See COPYING for more details.

require 'ducksauce/version'
require 'ducksauce/converter'
require 'ducksauce/ducktype'

module DuckSauce
  def self.included(target)
    target.extend DuckSauce::Converter
    target.extend DuckSauce::DuckType
  end
end
