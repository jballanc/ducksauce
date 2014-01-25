module DuckSauce
  module Converter
    def converter(klass, *args)
      mod, classname = module_classname_split(klass.name)
      mod.module_eval do
        define_method(classname.to_sym) do |other|
          return other if other.kind_of?(klass)
          raise TypeError, "can't convert #{other} into #{klass}"
        end
        module_function(classname.to_sym)
      end
    end

    private
    def module_classname_split(name)
      parts = name.split('::')
      mod = ::Kernel.const_get(parts[0..-2].join('::'))
      return mod, parts[-1]
    end
  end
end
