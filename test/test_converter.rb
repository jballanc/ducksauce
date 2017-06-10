require 'ducksauce/converter'
require 'minitest/autorun'

describe DuckSauce::Converter do
  describe 'A class that extends DuckSauce::Converter' do
    before do
      class Target
        extend DuckSauce::Converter
      end
    end

    it 'adds a converter class method' do
      Target.methods.must_include :converter
    end

    it 'creates a converter for the containing class' do
      Target.converter
      ::Kernel.methods.must_include :Target
    end
  end

  describe 'Used to create a default converter method' do
    before do
      class DefaultConverted
        extend DuckSauce::Converter
        converter
      end
      class Subject; end
    end

    it 'uses #kind_of? as the default test' do
      m = MiniTest::Mock.new
      m.expect(:kind_of?, true, [DefaultConverted])

      DefaultConverted(m)

      m.verify
    end

    it 'raises a TypeError if the argument is the wrong type' do
      s = Subject.new
      -> { DefaultConverted(s) }.must_raise(TypeError)
    end
  end

  describe 'Passed alternative methods to use for conversion' do
    before do
      class MethodConverted
        include DuckSauce
        converter :to_methconv, :to_mc
      end
    end

    it 'tests with #kind_of? first' do
      m = MiniTest::Mock.new
      m.expect(:kind_of?, true, [MethodConverted])

      MethodConverted(m)

      m.verify
    end

    it 'tries alternative methods in order' do
      m1 = MiniTest::Mock.new
      m2 = MiniTest::Mock.new
      c = MethodConverted.new

      m1.expect(:kind_of?, false, [MethodConverted])
      m1.expect(:to_methconv, c)
      def m1.to_mc; end

      MethodConverted(m1)

      m1.verify

      m2.expect(:kind_of?, false, [MethodConverted])
      m2.expect(:to_mc, c)

      MethodConverted(m2)

      m2.verify
    end
  end

  describe 'Using initialize for conversion' do
    it 'warns if the target does not have an initializer of the right arity' do
      warning = "WARNING: Initializer takes wrong number of args for conversion\n"

      -> {
        class WrongArity
          include DuckSauce
          converter use_initialize: true
        end
      }.must_output nil, warning
    end

    it 'calls `new` with the subject if #kind_of? is false' do
      class InitializeConverted
        include DuckSauce
        def initialize(subj); end
        converter use_initialize: true
      end
      m = MiniTest::Mock.new
      m.expect(:kind_of?, false, [InitializeConverted])

      r = InitializeConverted(m)

      r.must_be_kind_of InitializeConverted
    end
  end

  describe 'With a mix of methods available for conversion' do
    it 'checks type, then conversion method, then constructor in order' do
      class MixConverted
        include DuckSauce
        def initialize(subj); end
        converter :to_mix, use_initialize: true
      end
      m = MiniTest::Mock.new
      m.expect(:kind_of?, false, [MixConverted])
      m.expect(:respond_to?, false, [:to_mix])

      r = MixConverted(m)

      r.must_be_kind_of MixConverted
    end
  end
end
