require 'spec_helper'
require 'passwordsafe/keyring'
require 'passwordsafe/safe'

describe PasswordSafe::Keyring do
  it "expects to get a Safe to read/write" do
    PasswordSafe::Keyring.should respond_to(:new).with(1).argument
    keyring = PasswordSafe::Keyring.new(PasswordSafe::Safe.new("safefile","masterpass"))
    keyring.should have_a_safe
  end
end

