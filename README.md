# DuckSauce

Ruby is a duck typed language.

Yeah, I know. We've all heard that line before. What does that really *mean*
though? In theory, it means that if an object walks like a string, and talks
like a string, then it might as well be a string. The problem is, who decides
what constitutes "walking like a string" and "talking like a string"?

Well, you could just cover your eyes and pretend like the object you expect to
be a string actually acts like one. This can be a bit dangerous (even if you do
have really good test coverage), but more importantly this is a violation of
[Postel's Law](http://en.wikipedia.org/wiki/Postel%27s%5Flaw). What, then can you
do if you want to be able to handle not only explicit strings, but also objects
that can be converted into strings?

For this, there is the `String()` method in Ruby's `Kernel` module. Pass an
object in, and you'll get a string-ish thing out, guaranteed. Ok, but what about
your own classes? How should you handle the possibility that someone might not
hand you an instance of your class but instead an object that could still be
converted into the right thing? That's the first place DuckSauce can help out.

```ruby
module MyApp
  class MyDataType
    #...
  end

  class OtherThing
    def to_my_data(other)
      # code to convert other to a MyDataType instance
    end
  end

  converter MyDataType, :to_my_data
end
```

This will create a method `MyApp::MyDataType()` that can be used to turn
an instance of OtherThing (or any class that implements the `to_my_data` method)
into an instance of your custom class. Don't worry, if the object already is an
instance of MyDataType, this method is essentially a no-op.

Great, so now we can create our own methods like `String()` and `Array()`, but
what about using them to convert our arguments? Don't worry, DuckSauce has you
covered there as well:

```ruby
module MyApp
  class MyDataType
    ducktype(first: MyDataType, second: String, third: Integer) do
      def a_data_method(first, second, third)
        #...
      end
    end
  end
end
```

The `ducktype` method decorator will ensure that each of the arguments `first`,
`second`, and `third` are compatible with the `MyDataType`, `String`, and
`Integer` classes, respectively, by using the `Kernel` level methods to make the
check and/or conversion.

## Converters


## Type Coercion


## Contributing

As this project is still extremely young, the biggest thing you can do to help
right now is use it! If you find bugs, wish it worked a bit differently, or have
some ideas on how it could be made even better, please use the [issue tracker](https://github.com/jballanc/ducksauce/issues) to let me know. If you
are using it and would like to share any tips or tricks, please feel free to add
a page to the [wiki](https://github.com/jballanc/ducksauce/wiki). Thanks!

## Copyright

Ducksauce Copyright (c) 2014, Joshua Ballanco.

Licensed under the BSD 2-Clause License. See COPYING for full license details.

