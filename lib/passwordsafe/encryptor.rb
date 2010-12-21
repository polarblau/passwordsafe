require 'openssl'

module  PasswordSafe

  module Encryptor; extend self;

    def encrypt(data, pwhash)
      cipher = OpenSSL::Cipher.new 'aes-256-cbc'
      cipher.encrypt
      cipher.key = pwhash
      ciphertext = cipher.update(data)
      ciphertext += cipher.final
    end

    def hash (plain)
      Digest::SHA512.digest(plain)
    end
  end

end

