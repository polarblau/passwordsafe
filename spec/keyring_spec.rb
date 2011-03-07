require 'spec_helper'
require 'passwordsafe/keyring'
require 'clipboard'

describe PasswordSafe::Keyring do
  let(:safe) { mock PasswordSafe::Safe, :read_safe => {}, :write_safe => nil }
  let(:keyring) { PasswordSafe::Keyring.new(safe) }
  
  after (:each) do
    Clipboard.clear
  end

  it "expects to get a Safe to read/write" do
    safe.should_receive(:is_a?).and_return(true)
    PasswordSafe::Keyring.should respond_to(:new).with(1).argument
    keyring = PasswordSafe::Keyring.new(safe)
    keyring.should have_a_safe
  end

  describe "length" do

    it "returns the number of keys in the keyring" do
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

  describe "generate" do
    
    it "adds a generated password to the keyring" do
      keyring.should respond_to(:generate).with(1).arguments
      keyring.generate("name")
      keyring.length.should eq(1)
    end
    it "generates a password" do
      keyring.should respond_to(:generate).with(1).arguments
      password = keyring.generate("name")
      keyring.get("name").should eq(password)
    end
    it "generates a password of default length '8'" do
      keyring.generate("name").length.should eq(8)
    end
    it "generates a password of a specified length" do
      keyring.generate("name", 12).length.should eq(12)
    end
    it "throws an error when generating passord for a duplicate key name" do
      keyring.generate("name")
      expect{keyring.generate("name")}.to raise_error()
    end
    it "should copy the generated password to the clipboard" do
      password = keyring.generate("name")
      Clipboard.paste.should eq(password)
    end
    
  end

  
  describe "get" do

    it "gets a key from the keyring" do
      safe.stub(:read_safe).and_return({"name" => "password"})
      keyring.get("name").should eq("password")
    end
    it "throws an error if a key does not exist" do
      expect{keyring.get("name")}.to raise_error()
    end
    it "should copy the retrieved password to the clipboard" do
      safe.stub(:read_safe).and_return({"name" => "password"})
      password = keyring.get("name")
      Clipboard.paste.should eq(password)
    end
    
  end

  describe "list" do

    it "returns a list of existing key names" do
      safe.should_receive(:read_safe).and_return({"first" => "password", "second" => "password"})
      keyring.list.should eq(["first", "second"])
    end
    it "returns an empty array if there are no keys" do
      keyring.list.should eq([])
    end
  end

  describe "remove" do
    it "responds to 'remove'" do
      safe.stub(:read_safe).and_return({"name" => "password"})
      keyring.should respond_to(:remove).with(1).arguments
    end
    it "removes an existing key" do
      safe.should_receive(:read_safe).and_return({"first" => "password", "second" => "password"})
      keyring.remove("first")
      expect{keyring.get("first")}.to raise_error()
    end
    it "saves the modified keyring to the safe" do
      safe.should_receive(:read_safe).and_return({"first" => "password", "second" => "password"})
      safe.should_receive(:write_safe).with({"second" => "password"})
      keyring.remove("first")
    end
    it "throws an error if a key does not exist" do
      expect{keyring.remove("name")}.to raise_error()
    end
  end
end

