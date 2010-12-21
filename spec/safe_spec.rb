require 'spec_helper'
require 'passwordsafe/safe'

describe PasswordSafe::Safe do
  it "takes a safe filename at initilaization" do
    PasswordSafe::Safe.should respond_to(:new).with(1).argument
  end
  context "access_safe" do
    before(:each) do
      @filename = File.expand_path('passwordsafe')
      @safe = PasswordSafe::Safe.new(@filename)
    end
    it "creates a safe if none exists" do
      @safe.access_safe
      File.file?(@filename).should be_true
    end
    it "doesn't modify an existing safe" do
      content = "some existing file content"
      File.open(@filename, 'w') {|f| f.write content}
      @safe.access_safe
      File.read(@filename).should eq(content)
    end
    after(:each) do
      File.delete @filename
    end
  end

  context "write_safe" do
    before(:each) do
      @filename = File.expand_path('passwordsafe')
      @safe = PasswordSafe::Safe.new(@filename)
      klass = Class.new { include PasswordSafe::Encryptor}
      @encryptor = klass.new
    end

    it "creates a safe file to write to" do
      data = "data to encrypt"
      hash = @encryptor.hash('masterpass')

      @safe.write_safe(data, hash)
      File.file?(@filename).should be_true
    end

    it "writes encrypted data to a safe" do
      data = "data to encrypt"
      hash = @encryptor.hash('masterpass')

      @safe.write_safe(data, hash)
      @encryptor.decrypt(File.read(@filename), hash).should eq(data)
    end

    after(:each) do
      File.delete @filename
    end
  end
end # describe PasswordSafe::Safe

