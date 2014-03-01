require 'spec_helper'

describe User do
  describe "#send message" do
    before(:each) do
      @alice = User.create! :subscription => Subscription.new
      @bob = User.create!
    end
    
    context "when the user is under their subscription limit" do
      before(:each) do
        @alice.subscription.stub(:can_send_message?).and_return true
      end
      
      it "creates a new message with the submitted attributes" do
        msg = @alice.send_message(
          :title => "Oldest Joke",
          :text => "Lookest thou over there",
          :recipient => @bob
        )
        msg.title.should == "Oldest Joke"
        msg.text.should == "Lookest thou over there"
      end
      
     it "sends a message to another user" do
        msg = @alice.send_message(
          :title => "Oldest Joke",
          :text => "Lookest thou over there",
          :recipient => @bob
        )
        @bob.received_messages.should == [msg]
      end
      
      it "adds the message to the sender's sent messages" do
        msg = @alice.send_message(
          :title => "Oldest Joke",
          :text => "Lookest thou over there",
          :recipient => @bob
        )
        @alice.sent_messages.should == [msg]
      end
    end
    
    context "when the user is over their subscription limit" do
      before(:each) do
        @alice.subscription.stub(:can_send_message?).and_return false
      end
      
      it "does not create a message" do
        lambda {
          @alice.send_message(
            :title => "Oldest Joke",
            :text => "Lookest thou over there",
            :recipient => @bob
          )
          }.should_not change(Message, :count)
      end
    end
  end
end
