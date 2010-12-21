require 'spec_helper'
require 'passwordsafe/encryptor'

describe PasswordSafe::Encryptor do

  before(:each) do
    klass = Class.new { include PasswordSafe::Encryptor}
    @encryptor = klass.new
  end

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

