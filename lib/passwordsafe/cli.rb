require 'thor'
require 'passwordsafe/safe'
require 'passwordsafe/keyring'

module PasswordSafe
  class CLI < Thor
    DEFAULTSAFE = 'safefile'

    desc "add NAME PASSWORD", "Add a new PASSWORD to the keyring with name NAME"
    def add name, password
      safe = make_safe
      begin
        PasswordSafe::Keyring.new(safe).add name, password
      rescue PasswordSafe::Keyring::KeyExistsException => msg
        puts "#{msg}"
      else
        puts "password #{name} added to safe"
      end
    end
    
    desc "generate NAME", "Generate a new PASSWORD and add it to the keyring with NAME"
    method_options :length => 8
    def generate name
      safe = make_safe
      begin
        password = PasswordSafe::Keyring.new(safe).generate(name, options[:length])
      rescue PasswordSafe::Keyring::KeyExistsException => msg
        puts "#{msg}"
      else
        puts "password #{password} generated and added to safe"
      end
    end

    desc "get NAME", "Get an existing password with name NAME from keyring"
    def get name
      safe = make_safe
      password = PasswordSafe::Keyring.new(safe).get name
      if password.nil?
        puts "#{name} does not exist in this safe."
      else
        puts "#{name}: #{password}"
      end
    end

    desc "list", "List the names of all the existing passwords in the safe"
    def list
      safe = make_safe
      keys = PasswordSafe::Keyring.new(safe).list
      puts "List: (none)" if keys.empty?
      puts "List: #{keys.join(", ")}"
    end

    no_tasks do
      def make_safe filename = DEFAULTSAFE
        masterpass = ask("Enter your master password:  ") { |q| q.echo = "x" }
        PasswordSafe::Safe.new(filename, masterpass)
      end
    end
  end
end

