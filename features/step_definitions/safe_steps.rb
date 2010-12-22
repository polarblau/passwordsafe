require 'passwordsafe/safe'
require 'passwordsafe/keyring'
require 'passwordsafe/cli'

Given /^A safe exists with masterpassword "([^"]*)" and a "([^"]*)" key$/ do |masterpass, key_name|
  in_current_dir do
    safe = PasswordSafe::Safe.new(PasswordSafe::CLI::DEFAULTSAFE, masterpass)
    PasswordSafe::Keyring.new(safe).add key_name, "dummypass"
  end
end

