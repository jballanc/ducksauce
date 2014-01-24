module DuckSauce
  module Converter
    def converter(klass, *args)
      Kernel.module_eval do
        define_method(klass.name.to_sym) do |other|
          return other if other.kind_of?(klass)
          raise TypeError, "can't convert #{other.class} into #{klass}"
        end
      end
    end
  end
end
