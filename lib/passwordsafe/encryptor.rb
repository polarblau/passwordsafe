require 'openssl'

module  PasswordSafe

  module Encryptor; extend self;

    def decrypt(data, pwhash)
      crypt :decrypt, data, pwhash
    end

    def encrypt(data, pwhash)
      crypt :encrypt, data, pwhash
    end

    def hash (plain)
      Digest::SHA512.digest(plain)
    end

    private
      def crypt(mode, data, pwhash)
        cipher = OpenSSL::Cipher.new 'AES256'
        cipher.send mode.to_sym
        cipher.key = pwhash
        cipher.update(data) << cipher.final
      end
  end
end

