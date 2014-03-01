require 'spec_helper'

describe User do
  describe "#send message" do
    context "when the user is under their subscription limit" do
      it "sends a message to another user" do
        alice = User.create!
        bob = User.create!
        msg = alice.send_message(
          :title => "Oldest Joke",
          :text => "Lookest thou over there",
          :recipient => bob
        )
        bob.received_messages.should == [msg]
      end
      
      it "creates a new message with the submitted attributes" do
        alice = User.create!
        bob = User.create!
        msg = alice.send_message(
          :title => "Oldest Joke",
          :text => "Lookest thou over there",
          :recipient => bob
        )
        msg.title.should == "Oldest Joke"
        msg.text.should == "Lookest thou over there"
      end
      
      it "adds the message to the sender's sent messages" do
                alice = User.create!
        bob = User.create!
        msg = alice.send_message(
          :title => "Oldest Joke",
          :text => "Lookest thou over there",
          :recipient => bob
        )
        alice.sent_messages.should == [msg]
      end
    end
  end
end
