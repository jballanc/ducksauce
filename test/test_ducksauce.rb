require 'ducksauce'
require 'minitest/autorun'

describe DuckSauce do
  describe 'In the context of a Module' do
    before do
      module Example
        module Namespace
          include DuckSauce
          class Target; end
        end
      end

      class Subject; end
    end

    it 'adds a converter method to the module' do
      Example::Namespace.methods.must_include :converter
    end

    it 'creates a converter method scoped to the containing namespace' do
      module Example::Namespace
        converter Target
      end

      Example::Namespace.methods.must_include :Target
    end
  end
end
