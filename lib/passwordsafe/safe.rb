require 'passwordsafe/encryptor'

module PasswordSafe
  class Safe
    include PasswordSafe::Encryptor

    def initialize filename
      @safefile = File.expand_path(filename)
    end

    def access_safe
      FileUtils.touch @safefile
    end
    def write_safe data, hash
      access_safe
      encrypted_data = encrypt(data, hash)
      File.open(@safefile, 'w') {|f| f.write encrypted_data}
    end
    def read_safe hash
      decrypt(File.read(@safefile), hash)
    end
  end
end

