require 'passwordsafe/safe'
require 'passwordsafe/keyring'
require 'passwordsafe/cli'
require 'clipboard'

Given /^A safe exists with masterpassword "([^"]*)"$/ do |masterpass|
  in_current_dir do
    @safe = PasswordSafe::Safe.new(PasswordSafe::CLI::DEFAULTSAFE, masterpass)
  end
end

Given /^A safe exists with masterpassword "([^"]*)" and a "([^"]*)" key$/ do |masterpass, key_name|
  in_current_dir do
    @safe = PasswordSafe::Safe.new(PasswordSafe::CLI::DEFAULTSAFE, masterpass)
    PasswordSafe::Keyring.new(@safe).add key_name, "dummypass"
  end
end

Given /^A safe exists with masterpassword "([^"]*)" and the keys$/ do |masterpass, keys_table|
  in_current_dir do
    @safe = PasswordSafe::Safe.new(PasswordSafe::CLI::DEFAULTSAFE, masterpass)
    keys_table.hashes.each do |key_hash|
      PasswordSafe::Keyring.new(@safe).add key_hash[:key], "dummypass"
    end
  end
end

Given /^A safe exists with masterpassword "([^"]*)" and "([^"]*)" keys$/ do |masterpass, keys|
  in_current_dir do
    @safe = PasswordSafe::Safe.new(PasswordSafe::CLI::DEFAULTSAFE, masterpass)

    keys.to_i.times do |i|
      PasswordSafe::Keyring.new(@safe).add "pass#{i}", "dummypass"
    end
  end
end

Then /^the clipboard should contain the password for the "([^"]*)" key$/ do |key_name|
  password = PasswordSafe::Keyring.new(@safe).get key_name
  password.should eq(Clipboard.paste)
end

