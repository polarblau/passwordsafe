
module PasswordSafe
  class Keyring

    def initialize safe = nil
      @safe = safe
    end

    def has_a_safe?
      @safe.is_a? PasswordSafe::Safe
    end
  end
end

