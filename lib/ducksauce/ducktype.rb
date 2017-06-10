module DuckSauce
  module DuckType
    class DuckTypedMethod
      def initialize(meth_imp)
      end

      def dispatch_on(args, kwargs)
        puts "Called a DuckTypedMethod..."
      end
    end

    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def method_added(mid)
        unless @__ducktype_adding_method
          @__ducktype_adding_method = true
          puts "Added method: #{mid}"
          puts "Argspec: #{@__ducktype_argspec}"
          dtm = DuckTypedMethod.new(instance_method(mid))
          instance_eval do
            define_method(mid) do |*args, **kwargs|
              dtm.dispatch_on(args, kwargs)
            end
          end
          @__ducktype_adding_method = false
        end
      end

      def ducktype(**argspec)
        @__ducktype_argspec = argspec
      end
    end
  end
end
