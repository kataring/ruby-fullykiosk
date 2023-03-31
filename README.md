# ruby-fullykiosk

Ruby wrapper for Fully Kiosk Browser REST interface.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fullykiosk'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install fullykiosk
```

## Usage

```ruby
client = FullyKiosk::Client.new(email: 'YOUR_EMAIL', api_key: 'YOUR_API_KEY')

client.devices(123)
client.device('12345-abcde')
client.status('12345-abcde')
client.reboot('12345-abcde')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
