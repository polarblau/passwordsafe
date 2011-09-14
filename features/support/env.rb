require "bundler/setup"
require 'aruba/cucumber'
require 'clipboard'

ENV['SAFEFILE'] = 'safefile'
require 'passwordsafe/safe'
require 'passwordsafe/keyring'
require 'passwordsafe/cli'

After do |s|
  remove_file(PasswordSafe::CLI::DEFAULTSAFE)
  Clipboard.clear
end

