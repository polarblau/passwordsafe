require 'spec_helper'
require 'passwordsafe/keyring'

describe PasswordSafe::Keyring do
  let(:safe) { mock PasswordSafe::Safe, :read_safe => {}, :write_safe => nil }
  let(:keyring) { PasswordSafe::Keyring.new(safe) }

  it "expects to get a Safe to read/write" do
    safe.should_receive(:is_a?).and_return(true)
    PasswordSafe::Keyring.should respond_to(:new).with(1).argument
    keyring = PasswordSafe::Keyring.new(safe)
    keyring.should have_a_safe
  end

  describe "length" do

    it "returns the number of keys in the keyring" do
      keyring = PasswordSafe::Keyring.new(safe)
      keyring.should respond_to(:length)
      keyring.length.should be_a(Integer)
    end
  end

  describe "add" do

    it "adds a key to the keyring" do
      keyring.should respond_to(:add).with(2).arguments
      keyring.add("name", "password")
      keyring.length.should eq(1)
    end
    it "throws an error when adding a duplicate key name" do
      keyring.add("name", "password")
      expect{keyring.add("name", "password")}.to raise_error()
    end
    it "saves the modified keyring to the safe" do
      safe.should_receive(:write_safe).with({"name" => "password"})
      keyring.add("name", "password")
    end
  end

  describe "get" do

    it "gets a key from the keyring" do
      safe.stub(:read_safe).and_return({"name" => "password"})
      keyring = PasswordSafe::Keyring.new(safe)
      keyring.get("name").should eq("password")
    end
    it "returns nil if the key does not exist" do
      keyring.get("name").should be_nil
    end
  end

  describe "list" do

    it "returns a list of existing key names" do
      safe.should_receive(:read_safe).and_return({"first" => "password", "second" => "password"})
      keyring = PasswordSafe::Keyring.new(safe)
      keyring.list.should eq(["first", "second"])
    end
    it "returns an empty array if there are no keys" do
      keyring.list.should eq([])
    end
  end

  describe "remove" do

    it "removes an existing key" do
      safe.should_receive(:read_safe).and_return({"first" => "password", "second" => "password"})
      keyring = PasswordSafe::Keyring.new(safe)
      keyring.remove("first")
      keyring.get("first").should eq(nil)
    end
    it "saves the modified keyring to the safe" do
      safe.should_receive(:read_safe).and_return({"first" => "password", "second" => "password"})
      safe.should_receive(:write_safe).with({"second" => "password"})
      keyring = PasswordSafe::Keyring.new(safe)
      keyring.remove("first")
    end
  end
end

