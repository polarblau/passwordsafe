require 'passwordsafe/encryptor'

module PasswordSafe
  class Safe
    include PasswordSafe::Encryptor

    def initialize filename, masterpass
      @safefile = File.expand_path(filename)
      @mphash = hash(masterpass)
    end

    def access_safe
      FileUtils.touch @safefile
    end
    def write_safe data
      access_safe
      encrypted_data = encrypt(data, @mphash)
      File.open(@safefile, 'w') {|f| f.write encrypted_data}
    end
    def read_safe
      decrypt(File.read(@safefile), @mphash)
    end
  end
end

