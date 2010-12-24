require 'spec_helper'
require 'passwordsafe/encryptor'

describe PasswordSafe::Encryptor do
  let(:encryptor) {(Class.new { include PasswordSafe::Encryptor}).new }

  describe "hash" do
    it "creates a password hash" do
      encryptor.should respond_to(:hash).with(1).argument
      encryptor.hash("test").should be_a(String)
    end

    it "creates the same hash given the same text" do
      encryptor.hash("test").should eq(encryptor.hash("test"))
    end

    it "creates a different hash given different text" do
      encryptor.hash("test").should_not eq(encryptor.hash("another"))
    end
  end
  describe "encrypt" do
    let(:string) { "teststring" }
    let(:hash) { encryptor.hash("hashstring") }

    it "encrypts a string" do
      encryptor.should respond_to(:encrypt).with(2).arguments
      encryptor.encrypt(string, hash).should be_a(String)
    end
    it "creates the same string given the same text" do
      encryptor.encrypt(string, hash).should eq(encryptor.encrypt(string, hash))
    end
    it "creates a different string given different text" do
      encryptor.encrypt(string, hash).should_not eq(encryptor.encrypt("anotherstring", hash))
    end
  end
  describe "decrypt" do
    let(:string) { "teststring" }
    let(:hash) { encryptor.hash("hashstring") }
    let(:data) { encryptor.encrypt(string, hash) }

    it "decrypts a string" do
      encryptor.should respond_to(:decrypt).with(2).arguments
      encryptor.decrypt(data, hash).should be_a(String)
    end
    it "decrypts an encrypted string" do
      encryptor.decrypt(data, hash).should eq(string)
    end
  end
end # describe PasswordSafe::Encryptor

