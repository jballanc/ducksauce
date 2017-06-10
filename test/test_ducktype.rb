require 'ducksauce/ducktype'
require 'minitest/autorun'

describe DuckSauce::DuckType do
  it 'registers a spec on method definition' do
    class Target
      include DuckSauce::DuckType

      ducktype
      def ducktyped_method; end
    end
  end

  it 'replaces the method with a DuckTyped object' do
    klass = Class.new do
      include DuckSauce::DuckType

      ducktype(bar: Integer)
      def ducktyped_method(bar)
        puts "orig meth"
      end
    end

    puts klass.method(:ducktype).class
    klass.new.ducktyped_method("foo")
  end
end
