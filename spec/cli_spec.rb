require 'spec_helper'
require 'passwordsafe/cli'

describe PasswordSafe::CLI do
  context "command interface" do
    let(:mock_keyring) { mock PasswordSafe::Keyring}
    before(:each) do
      subject.stub(:get_keyring).and_return(mock_keyring)
      subject.stub(:puts)
    end
    describe "#add" do
      it "creates a new key in the keyring" do
        mock_keyring.should_receive(:add).with("name", "pass")
        subject.add("name", "pass")
      end
      it "displays a KeyExistsException" do
        mock_keyring.stub(:add) { raise PasswordSafe::Keyring::KeyExistsException, "dummy msg" }
        subject.should_receive(:puts).with("dummy msg")
        subject.add("name", "pass")
      end
      it "displays a msg to the user on sucessfull add" do
        mock_keyring.stub(:add)
        subject.should_receive(:puts).with("password name added to safe")
        subject.add("name", "pass")
      end
    end
    describe "#generate" do
      it "generates a password" do
        mock_keyring.should_receive(:generate)
        subject.generate("name")
      end
      it "displays a KeyExistsException" do
        mock_keyring.stub(:generate) { raise PasswordSafe::Keyring::KeyExistsException, "dummy msg" }
        subject.should_receive(:puts).with("dummy msg")
        subject.generate("name")
      end
      it "displays a msg to the user on sucessfull generate" do
        mock_keyring.stub(:generate).and_return("pass")
        subject.should_receive(:puts).with("password pass generated and added to safe")
        subject.generate("name")
      end
    end
    describe "#get" do
      it "gets the named password from the safe" do
        mock_keyring.should_receive(:get).with("name")
        subject.get "name"
      end
      it "tells the user if a password does not exist" do
        mock_keyring.stub(:get).with("name").and_return(nil)
        subject.should_receive(:puts).with("name does not exist in this safe.")
        subject.get "name"
      end
      it "tells the user the password" do
        mock_keyring.stub(:get).with("name").and_return("pass")
        subject.should_receive(:puts).with("name: pass")
        subject.get "name"
      end
    end
    describe "#remove" do
      it "removes a key from the keyring" do
        mock_keyring.should_receive(:remove).with("name")
        subject.remove("name")
      end
      it "displays a KeyMissingException" do
        mock_keyring.stub(:remove) { raise PasswordSafe::Keyring::KeyMissingException, "dummy msg" }
        subject.should_receive(:puts).with("dummy msg")
        subject.remove("name")
      end
      it "displays a msg to the user on sucessfull remove" do
        mock_keyring.stub(:remove)
        subject.should_receive(:puts).with("entry has been removed")
        subject.remove("name")
      end
    end
    describe "#change" do
      it "changes a key in the keyring" do
        mock_keyring.should_receive(:change).with("name", "pass")
        subject.change("name", "pass")
      end
      it "displays a KeyMissingException" do
        mock_keyring.stub(:change) { raise PasswordSafe::Keyring::KeyMissingException, "dummy msg" }
        subject.should_receive(:puts).with("dummy msg")
        subject.change("name", "pass")
      end
      it "displays a msg to the user on sucessfull change" do
        mock_keyring.stub(:change)
        subject.should_receive(:puts).with("password for name has been updated")
        subject.change("name", "pass")
      end
    end
    describe "#list" do
      it "displays (none) if there are no keys" do
        mock_keyring.stub(:list).and_return([])
        subject.should_receive(:puts).with("List:\n (none)")
        subject.list
      end
      it "displays keys if they exist" do
        mock_keyring.stub(:list).and_return(["pass1", "pass2"])
        subject.should_receive(:puts).with("List:\n pass1\n pass2")
        subject.list
      end
      it "displays keys in alphabetical order" do
        mock_keyring.stub(:list).and_return(["password", "another"])
        subject.should_receive(:puts).with("List:\n another\n password")
        subject.list
      end
    end
  end
  context "helpers" do
    describe "#make_safe" do
      let(:askable) { mock Object, :ask => "dummy" }
      before(:each) do
        HighLine.stub(:new).and_return(askable)
        PasswordSafe::Safe.stub(:new)
      end
      it "initializes a safe" do
        PasswordSafe::Safe.should_receive(:new)
        subject.make_safe
      end
      it "asks the user for a master safe password" do
        askable.should_receive(:ask)
        subject.make_safe
      end
    end
    describe "#get_keyring" do
      it "creates a keyring" do
        subject.stub(:make_safe).and_return(mock(PasswordSafe::Safe))
        PasswordSafe::Keyring.should_receive(:new)
        subject.get_keyring
      end
      it "re-calls make_safe if it fails to open the keyring" do
        subject.should_receive(:make_safe).twice.and_return(mock(PasswordSafe::Safe))
        PasswordSafe::Keyring.stub(:new){ raise OpenSSL::Cipher::CipherError }
        subject.stub(:abort)
        subject.get_keyring
      end
    end
  end
end
