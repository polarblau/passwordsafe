require 'thor'
require 'passwordsafe/safe'
require 'passwordsafe/keyring'

module PasswordSafe
  class CLI < Thor
    DEFAULTSAFE = 'safefile'

    desc "add NAME PASSWORD", "Add a new PASSWORD to the keyring with name NAME"
    def add name, password
      safe = make_safe
      PasswordSafe::Keyring.new(safe).add name, password
      puts "password #{name} added to safe"
    end

    def make_safe filename = DEFAULTSAFE
      masterpass = ask("Enter your master password:  ") { |q| q.echo = "x" }
      PasswordSafe::Safe.new(filename, masterpass)
    end
  end
end

