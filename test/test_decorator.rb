require 'ducksauce'
require 'minitest/autorun'

=begin
class Foo
  include DuckSauce

  ducktype(bar: String, baz: Quux)
  def foo(bar, baz)

  end
end
=end

describe DuckSauce::DuckType do
  describe 'A class that extends DuckSauce::DuckType' do
    before do
    end
  end
end
