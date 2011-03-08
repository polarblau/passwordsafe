require 'passwordsafe/safe'
require 'clipboard'

module PasswordSafe
  class Keyring
    class KeyExistsException < StandardError; end
    class KeyMissingException < StandardError; end

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
      @safe.write_safe @ring
    end
    
    def change name, password
      raise KeyMissingException, "#{name} does not exist in this safe.", caller unless @ring.has_key?(name)
      @ring[name] = password
      @safe.write_safe @ring
    end

    def generate name, length = 8
      raise KeyExistsException, "Key already exists in keyring, if you'd like to add it remove the existing key", caller if @ring.has_key?(name)
      password = generate_password(length)
      @ring.store(name, password)
      @safe.write_safe @ring
      Clipboard.copy(password)
      password
    end

    def get name
      raise KeyMissingException, "#{name} does not exist in this safe.", caller unless @ring.has_key?(name)
      password = @ring[name]
      Clipboard.copy(password)
      password
    end

    def remove name
      raise KeyMissingException, "#{name} does not exist in this safe.", caller unless @ring.has_key?(name)
      @ring.delete(name)
      @safe.write_safe @ring
    end

    def list
      @ring.keys
    end

    private
      def load_from_safe
        @safe.read_safe
      end
      
      def generate_password(len)
        Array.new(len/2) { rand(256) }.pack('C*').unpack('H*').first
      end
  end
end

