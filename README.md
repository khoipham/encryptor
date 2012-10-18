# Encryptor

Encrypt sensitive data on your ActiveRecord models or plain ol' Ruby objects using AES.

## Installation

Add this line to your application's Gemfile:

    gem 'encryptor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install encryptor

## Usage

Add this line within the class definition to any object, ActiveRecord model or not, you want to encrypt sensitive data:

    $ include Encryptor

For any attribute you want to encrypt, add the line:

    $ encrypted :attribute_name

This assumes you have two other attributes named encrypted_#{attribute_name} and #{attribute_name}_key.

It will then create #{attribute_name} and #{attribute_name}= methods that will transparently decrypt and encrypt the attribute.

Optionally, you can have two arguments that override the default name of the encrypted attribute and attribute key, like so:

    $ encrypted :attribute_name, :optional_encrypted_attribute_name, :optional_attribute_key

## TODO

* Tests, tests, tests
* Refactor out usage of AES into a strategy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
