require 'ducksauce'
require 'minitest/autorun'

describe DuckSauce::Converter do
  before do
    class Target
      include DuckSauce
    end

    class Subject; end
  end

  it 'Adds a converter class method when the class includes DuckSauce' do
    Target.methods.must_include :converter
  end

  describe 'used to create a default converter method' do
    before do
      class Target
        converter Target
      end
    end

    it 'adds a method to Kernel with the name of the target class' do
      Kernel.methods.must_include :Target
    end

    it 'uses #kind_of? as the default test' do
      m = MiniTest::Mock.new
      m.expect(:kind_of?, true, [Target])

      Target(m)

      m.verify
    end

    it 'raises a TypeError if the argument is the wrong type' do
      s = Subject.new
      -> { Target(s) }.must_raise(TypeError)
    end
  end
end
