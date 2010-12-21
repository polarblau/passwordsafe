require 'passwordsafe/encryptor'

module PasswordSafe
  class Safe
    include PasswordSafe::Encryptor

    def initalize filename
    end

    def access_safe filename
      FileUtils.touch filename
    end
    def write_safe filename, data, hash
      access_safe filename
      encrypted_data = encrypt(data, hash)
      File.open(filename, 'w') {|f| f.write encrypted_data}
    end
  end
end

