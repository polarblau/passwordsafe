require 'spec_helper'
require 'passwordsafe/safe'

describe PasswordSafe::Safe do
  let(:file) { 'passwordsafe' }
  let(:filename) { File.expand_path(file) }
  let(:masterpass) {'masterpass' }
  let(:safe) { PasswordSafe::Safe.new(file, masterpass) }

  it "takes a safe filename and master password at initilaization" do
    PasswordSafe::Safe.should respond_to(:new).with(2).arguments
  end

  context "access_safe" do

    it "creates a safe if none exists" do
      safe.access_safe
      File.file?(filename).should be_true
    end
    it "doesn't modify an existing safe" do
      content = "some existing file content"
      File.open(filename, 'w') {|f| f.write content}
      safe.access_safe
      File.read(filename).should eq(content)
    end
  end

  context "write_safe" do
    let(:encryptor) {(Class.new { include PasswordSafe::Encryptor}).new }
    let(:data) { ({"data" => "encrypt"}) }

    it "creates a safe file to write to" do
      safe.write_safe(data)
      File.file?(filename).should be_true
    end

    it "writes encrypted data to a safe" do
      safe.write_safe(data)

      #we'll use our encryptor to check the contents
      hash = encryptor.hash(masterpass)
      Marshal.load(encryptor.decrypt(File.read(filename), hash)).should eq(data)
    end
  end

  context "read_safe" do
    let(:data) { ({"data" => "encrypt"}) }

    it "reads encrypted data out of an existing safe" do
      safe.write_safe(data)
      safe.read_safe.should eq(data)
    end
  end

  after(:each) do
    #We check on the existance of files when we expect them to exist so this seems ok
    File.delete filename if File.file?(filename)
  end
end # describe PasswordSafe::Safe

