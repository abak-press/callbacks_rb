# CallbacksRb

External callbacks

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'callbacks_rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install callbacks_rb

## Usage

```ruby
class Foo
  include CallbacksRb

  callback :on_bar

  def bar
    fire_callback(:on_bar, 'param')
  end
end

Foo.new.on_bar do |arg|
  puts arg.inspect
end

Foo.bar
```

## Contributing

1. Fork it ( https://github.com/abak-press/callbacks_rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
