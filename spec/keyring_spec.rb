require 'spec_helper'
require 'passwordsafe/keyring'
require 'passwordsafe/safe'

describe PasswordSafe::Keyring do
  it "expects to get a Safe to read/write" do
    PasswordSafe::Keyring.should respond_to(:new).with(1).argument
    keyring = PasswordSafe::Keyring.new(PasswordSafe::Safe.new("safefile","masterpass"))
    keyring.should have_a_safe
  end

  context "length" do
    it "returns the number of keys in the keyring" do
      keyring = PasswordSafe::Keyring.new(PasswordSafe::Safe.new("safefile","masterpass"))
      keyring.should respond_to(:length)
      keyring.length.should be_a(Integer)
    end
  end

  context "add" do
    before(:each) do
      @keyring = PasswordSafe::Keyring.new(PasswordSafe::Safe.new("safefile","masterpass"))
    end
    it "adds a key to the keyring" do
      @keyring.should respond_to(:add).with(2).arguments
      @keyring.add("name", "password")
      @keyring.length.should eq(1)
    end
    it "throws an error when adding a duplicate key name" do
      @keyring.add("name", "password")
      expect{@keyring.add("name", "password")}.to raise_error()
    end
  end
end

