require "bundler/setup"
require 'aruba/cucumber'
require 'clipboard'

require 'passwordsafe/safe'
require 'passwordsafe/keyring'
require 'passwordsafe/cli'

After do |s|
  remove_file(PasswordSafe::CLI::DEFAULTSAFE)
  Clipboard.clear
end

