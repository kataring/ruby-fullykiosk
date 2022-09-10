# fullykiosk-ruby

Ruby client library for Fully Kiosk API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fullykiosk'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install fullykiosk
```

## Usage

```ruby
client = FullyKiosk::Client.new(email: 'YOUR_EMAIL', api_key: 'YOUR_API_KEY')

# get device list
pp client.list_devices
{"status"=>"OK",
 "statustext"=>"Found 5 devices",
 "devices"=>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request