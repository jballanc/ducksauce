module DuckSauce
  module Converter
    def converter(klass=self, *conv_meths, use_initialize: false)
      klass, conv_meths = adjust_args(klass, conv_meths)
      mod, classname = module_classname_split(klass.name)


      if use_initialize && !valid_initialize_arity(klass)
        use_initialize = false
        warn("WARNING: Initializer takes wrong number of args for conversion")
      end

      mod.module_eval do
        define_method(classname.to_sym) do |other|
          return other if other.kind_of?(klass)
          conv_meths.each do |conv_meth|
            return other.send(conv_meth) if other.respond_to? conv_meth
          end
          raise TypeError, "can't convert #{other} into #{klass}"
        end
        module_function(classname.to_sym)
      end
    end

    private
    def adjust_args(klass, conv_meths)
      # First argument can be left off if called in the context of a Class or
      # Module
      if !klass.kind_of? Module
        if klass.to_s == "main"
          raise ArgumentError,<<-END.lines.map(&:lstrip).join(' ')
            `converter` called outside the scope of a class or module definition
            must specify a target type
          END
        end
        conv_meths.unshift(klass)
        klass = self
      end
      return klass, conv_meths
    end

    def module_classname_split(name)
      parts = name.split('::')
      mod_name = parts[0..-2].join('::')
      mod = mod_name == '' ? ::Kernel : ::Kernel.const_get(mod_name)
      return mod, parts[-1]
    end

    def valid_initialize_arity(klass)
      params = klass.instance_method(:initialize).parameters.group_by(&:first)
      params.default = []

      # Initialize should not have any required keyword params, and must have
      # at least one required, optional, or rest param, but not more than one
      # required param:
      keyreq = params[:keyreq].count
      req = params[:req].count
      opt_rest = (params[:opt] + params[:rest]).count

      keyreq == 0 && req < 2 && (req + opt_rest) > 0
    end
  end
end
