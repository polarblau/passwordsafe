module  PasswordSafe

  module Encryptor; extend self;

    def hash (plain)
      #Digest::SHA2.new().update(plain).digest
    end
  end

end

