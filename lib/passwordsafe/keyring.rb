require 'passwordsafe/safe'

module PasswordSafe
  class Keyring

    def initialize safe = nil
      @safe = safe
      @ring = load_from_safe
    end

    def has_a_safe?
      @safe.is_a? PasswordSafe::Safe
    end

    def length
      @ring.length
    end

    def add name, password
      raise KeyExistsException, "Key already exists in keyring, if you'd like to add it remove the existing key", caller if @ring.has_key?(name)
      @ring.store(name, password)
    end

    def get name
      @ring[name]
    end

    private
      def load_from_safe
        @safe.read_safe
      end
  end
end

