require 'passwordsafe/encryptor'

module PasswordSafe
  class Safe
    include PasswordSafe::Encryptor

    def initialize filename, masterpass
      @safefile = File.expand_path(filename)
      @mphash = hash(masterpass)
    end

    def access_safe
      unless File.file? @safefile
        FileUtils.touch @safefile
        write_safe
      end
    end
    def write_safe data = {}
      dump = Marshal.dump(data)
      access_safe
      encrypted_data = encrypt(dump, @mphash)
      File.open(@safefile, 'w') {|f| f.write encrypted_data}
    end
    def read_safe
      access_safe
      Marshal.load decrypt(File.read(@safefile), @mphash) || {}
    end
  end
end

