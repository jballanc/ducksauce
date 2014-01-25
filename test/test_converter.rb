require 'ducksauce'
require 'minitest/autorun'

describe DuckSauce::Converter do
  describe 'Used in the context of a Module' do
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

    describe 'used to create a default converter method' do
      before do
        module Example::Namespace
          converter Target
        end
      end

      it 'adds a method to the module with the name of the target class' do
        Example::Namespace.methods.must_include :Target
      end

      it 'uses #kind_of? as the default test' do
        m = MiniTest::Mock.new
        m.expect(:kind_of?, true, [Example::Namespace::Target])

        Example::Namespace::Target(m)

        m.verify
      end

      it 'raises a TypeError if the argument is the wrong type' do
        s = Subject.new
        -> { Example::Namespace::Target(s) }.must_raise(TypeError)
      end
    end
  end
end
