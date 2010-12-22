require "bundler/setup"
require 'aruba/cucumber'

After do |s|
  remove_file(PasswordSafe::CLI::DEFAULTSAFE)
end

