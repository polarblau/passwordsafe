require 'spec_helper'
require 'passwordsafe/safe'

describe PasswordSafe::Safe do
  before (:each) do
    @file = 'passwordsafe'
    @filename = File.expand_path(@file)
    @masterpass = 'masterpass'
  end
  it "takes a safe filename and master password at initilaization" do
    PasswordSafe::Safe.should respond_to(:new).with(2).arguments
  end
  context "access_safe" do
    before(:each) do
      @safe = PasswordSafe::Safe.new(@file, @masterpass)
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
  end

  context "write_safe" do
    before(:each) do
      @safe = PasswordSafe::Safe.new(@file, @masterpass)
      klass = Class.new { include PasswordSafe::Encryptor}
      @encryptor = klass.new
    end

    it "creates a safe file to write to" do
      data = "data to encrypt"
      @safe.write_safe(data)
      File.file?(@filename).should be_true
    end

    it "writes encrypted data to a safe" do
      data = "data to encrypt"
      hash = @encryptor.hash(@masterpass)

      @safe.write_safe(data)
      @encryptor.decrypt(File.read(@filename), hash).should eq(data)
    end
  end
  context "read_safe" do
    it "reads encrypted data out of an existing safe" do
      @safe = PasswordSafe::Safe.new(@file, @masterpass)
      data = "data to encrypt"
      @safe.write_safe(data)
      #got data into an existing safe...
      @safe.read_safe.should eq(data)
    end
  end
  after(:each) do
    #We check on the existance of files when we expect them to exist so this seems ok
    File.delete @filename if File.file?(@filename)
  end
end # describe PasswordSafe::Safe

