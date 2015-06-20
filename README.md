# NetAppManageability

Ruby binding to NetApp Manageability SDK.

[![Gem Version](https://badge.fury.io/rb/net_app_manageability.svg)](http://badge.fury.io/rb/net_app_manageability)
[![Code Climate](http://img.shields.io/codeclimate/github/ManageIQ/net_app_manageability.svg)](https://codeclimate.com/github/ManageIQ/net_app_manageability)
[![Dependency Status](https://gemnasium.com/ManageIQ/net_app_manageability.svg)](https://gemnasium.com/ManageIQ/net_app_manageability)

## Installation

First, install the NetApp Manageability SDK.  This is only provided by NetApp
directly.  For the next steps, we will assume these files are located in
`$INSTALL_DIR`.

Next, if using bundler

- Add this line to your application's Gemfile:

  ```ruby
  gem 'net_app_manageability'
  ```

- If the NetApp Manageability SDK is not available on the normal compile paths, then execute:

  ```sh
  bundle config build.net_app_manageability --with-netapp-manageability-sdk-include=$INSTALL_DIR/include --with-netapp-manageability-sdk-lib=$INSTALL_DIR/lib/linux-64
  ```

- And finally execute:

  ```sh
  bundle
  ```

Otherwise, if not using bundler

- If the NetApp Manageability SDK is not available on the normal compile paths, then execute:

  ```sh
  gem install net_app_manageability --with-netapp-manageability-sdk-include=$INSTALL_DIR/include --with-netapp-manageability-sdk-lib=$INSTALL_DIR/lib/linux-64
  ```

- Otherwise execute:

  ```sh
  gem install net_app_manageability
  ```

## Usage

For examples of usage, see the [examples](examples).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to compile the gem and run the tests.  If you want to just compile the gem, use `rake compile`.  If the NetApp Manageability SDK is not accessible via the normal compile paths, you make have to pass those locations to `rake compile` as follows:

    rake compile -- --with-netapp-manageability-sdk-include=$INSTALL_DIR/include --with-netapp-manageability-sdk-lib=$INSTALL_DIR/lib/linux-64

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ManageIQ/net_app_manageability.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
