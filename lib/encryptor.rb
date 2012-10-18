require 'encryptor/version'

require 'active_support/concern'
require 'aes'

module Encryptor
  extend ActiveSupport::Concern

  module ClassMethods
    # Preconditions
    # => attribute_name - symbol, it is the name of the virtual attribute you want to create
    # => (optional) encrypted_attribute_name - symbol, it is the name of the encrypted attribute
    # => (optional) key_name - symbol, it is the name of the key
    # Postconditions
    # => #{attribute_name} instance method is created and handles decryption
    # => #{attribute_name}= instance method is created and handles encryption
    def encrypted(attribute_name, encrypted_attribute_name = nil, key_name = nil)
      encrypted_attribute_name = encrypted_attribute_name.present? ? encrypted_attribute_name : "encrypted_#{attribute_name}"
      key_name = key_name.present? ? key_name : "#{attribute_name}_key"

      class_eval do
        define_method :"#{attribute_name}" do
          decrypt(self.send(encrypted_attribute_name), self.send(key_name))
        end

        define_method :"#{attribute_name}=" do |value_to_encrypt|
          encrypted_parts = encrypt(value_to_encrypt)

          key = encrypted_parts[:key]
          encrypted_attribute = encrypted_parts[:encrypted_attribute]

          self.send("#{key_name}=", key)

          self.send("#{encrypted_attribute_name}=", encrypted_attribute)
        end
      end
    end
  end

  # Preconditions
  # => encrypted_attribute - string, it is the encrypted value
  # => key, string, it is the key
  # Postconditions
  # => If both encrypted_attribute and key are present
  #      * Returns decrypted value - string
  # => Else
  #      * Returns nil
  def decrypt(encrypted_attribute, key)
    if encrypted_attribute.present? and key.present?
      AES.decrypt(encrypted_attribute, key)
    end
  end

  # Preconditions
  # => attribute - string, it is the unencrypted value
  # Postconditions
  # => If attribute is present
  #      * Returns a hash with the following keys:
  #        - key - string
  #        - encrypted_attribute - string
  # => Else
  #      * Returns a hash with the same keys as above but with nil values
  def encrypt(attribute)
    if attribute.present?
      key = AES.key

      encrypted_attribute = AES.encrypt(attribute, key)
    end

    {
      key: key,
      encrypted_attribute: encrypted_attribute
    }
  end
end
