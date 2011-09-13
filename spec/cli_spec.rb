require 'spec_helper'
require 'passwordsafe/cli'

describe PasswordSafe::CLI do
  describe "#add" do
    before(:each) do
      @dummy_safe = mock PasswordSafe::Safe
      subject.stub(:make_safe).and_return(@dummy_safe)
      @mock_keyring = mock PasswordSafe::Keyring
      PasswordSafe::Keyring.stub(:new).with(@dummy_safe).and_return(@mock_keyring)
    end
    it "creates a new key in the keyring" do
      @mock_keyring.should_receive(:add).with("name", "pass")
      subject.add("name", "pass")
    end
    it "displays a KeyExistsException" do
      @mock_keyring.stub(:add) { raise PasswordSafe::Keyring::KeyExistsException, "dummy msg" }
      subject.should_receive(:puts).with("dummy msg")
      subject.add("name", "pass")
    end
    it "displays a msg to the user on sucessfull add" do
      @mock_keyring.stub(:add)
      subject.should_receive(:puts).with("password name added to safe")
      subject.add("name", "pass")
    end
  end
  describe "#generate" do
    before(:each) do
      @dummy_safe = mock PasswordSafe::Safe
      subject.stub(:make_safe).and_return(@dummy_safe)
      @mock_keyring = mock PasswordSafe::Keyring
      PasswordSafe::Keyring.stub(:new).with(@dummy_safe).and_return(@mock_keyring)
    end
    it "generates a password" do
      @mock_keyring.should_receive(:generate)
      subject.generate("name")
    end
    it "displays a KeyExistsException" do
      @mock_keyring.stub(:generate) { raise PasswordSafe::Keyring::KeyExistsException, "dummy msg" }
      subject.should_receive(:puts).with("dummy msg")
      subject.generate("name")
    end
    it "displays a msg to the user on sucessfull generate" do
      @mock_keyring.stub(:generate).and_return("pass")
      subject.should_receive(:puts).with("password pass generated and added to safe")
      subject.generate("name")
    end
  end
end
