require 'passwordsafe/safe'
require 'passwordsafe/keyring'
require 'passwordsafe/cli'

Given /^A safe exists with masterpassword "([^"]*)" and a "([^"]*)" key$/ do |masterpass, key_name|
  in_current_dir do
    safe = PasswordSafe::Safe.new(PasswordSafe::CLI::DEFAULTSAFE, masterpass)
    PasswordSafe::Keyring.new(safe).add key_name, "dummypass"
  end
end

Given /^A safe exists with masterpassword "([^"]*)" and "([^"]*)" keys$/ do |masterpass, keys|
  in_current_dir do
    safe = PasswordSafe::Safe.new(PasswordSafe::CLI::DEFAULTSAFE, masterpass)

    keys.to_i.times do |i|
      PasswordSafe::Keyring.new(safe).add "pass#{i}", "dummypass"
    end
  end
end

