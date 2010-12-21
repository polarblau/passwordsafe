require 'spec_helper'
require 'passwordsafe/encryptor'

describe PasswordSafe::Encryptor do

  before(:each) do
    klass = Class.new { include PasswordSafe::Encryptor}
    @encryptor = klass.new
  end

  it "creates a password hash" do
    @encryptor.should respond_to(:hash).with(1).argument
  end

end

