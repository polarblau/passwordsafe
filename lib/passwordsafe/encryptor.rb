module  PasswordSafe

  module Encryptor; extend self;

    def hash (plain)
      Digest::SHA512.hexdigest(plain)
    end
  end

end

