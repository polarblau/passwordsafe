require 'passwordsafe/safe'
require 'clipboard'
require 'rqrcode_png'

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

    def generate name, length = nil
      raise KeyExistsException, "Key already exists in keyring, if you'd like to add it remove the existing key", caller if @ring.has_key?(name)
      length = length || (ENV.has_key?('PW_LENGTH') ? ENV['PW_LENGTH'].to_i : 8)
      password = generate_password(length)
      @ring.store(name, password)
      @safe.write_safe @ring
      Clipboard.copy(password)
      password
    end

    def get name, qr = nil
      raise KeyMissingException, "#{name} does not exist in this safe.", caller unless @ring.has_key?(name)
      password = @ring[name]

      if qr
        code = RQRCode::QRCode.new(password, :size => 6) # works fine with 48 chars
        png  = code.to_img
        file = File.new("/tmp/passwordsafe_qr_#{Time.new.to_i}.png", "w")
        png.resize(200, 200).save(file.path)
        `open #{file.path}`
      end

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

      def generate_password(length)
        allowed = [('A'..'Z'), ('a'..'z'), (0..9)].map(&:to_a) | %(!$%&/()=?_-+#*).split('')
        allowed.flatten!
        Array.new(length) { allowed.sample }.join
      end
  end
end

