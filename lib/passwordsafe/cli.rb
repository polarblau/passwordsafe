require 'thor'
require 'passwordsafe/safe'
require 'passwordsafe/keyring'

module PasswordSafe
  class CLI < Thor

    desc "add NAME PASSWORD", "Add a new PASSWORD to the keyring with name NAME"
    def add name, password
      safe = PasswordSafe::Safe.new('safefile', 'masterpass')
      PasswordSafe::Keyring.new(safe).add name, password
      puts "password #{name} added to safe"
    end
  end
end

