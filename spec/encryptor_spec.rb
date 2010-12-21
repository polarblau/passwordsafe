require 'spec_helper'
require 'passwordsafe/encryptor'

describe PasswordSafe::Encryptor do

  before(:each) do
    klass = Class.new { include PasswordSafe::Encryptor}
    @encryptor = klass.new
  end
  context "hash" do
    it "creates a password hash" do
      @encryptor.should respond_to(:hash).with(1).argument
      @encryptor.hash("test").should be_a(String)
    end

    it "creates the same hash given the same text" do
      @encryptor.hash("test").should eq(@encryptor.hash("test"))
    end

    it "creates a different hash given different text" do
      @encryptor.hash("test").should_not eq(@encryptor.hash("another"))
    end
  end
  context "encrypt" do
    before(:each) do
      @string = "teststring"
      @hash = @encryptor.hash("hashstring")
    end

    it "encrypts a string" do
      @encryptor.should respond_to(:encrypt).with(2).arguments
      @encryptor.encrypt(@string, @hash).should be_a(String)
    end
    it "creates the same string given the same text" do
      @encryptor.encrypt(@string, @hash).should eq(@encryptor.encrypt(@string, @hash))
    end
    it "creates a different string given different text" do
      @encryptor.encrypt(@string, @hash).should_not eq(@encryptor.encrypt("anotherstring", @hash))
    end
  end
end # describe PasswordSafe::Encryptor

