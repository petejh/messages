require 'spec_helper'

describe MessagesController do
  describe "POST create" do
    it "creates a new message" do
      message = mock_model(Message).as_null_object
      Message.should_receive(:new).with("text" => "a quick brown fox").and_return(message)
      post :create, :message => { "text" => "a quick brown fox" }
    end
    it "saves the message" do
      message = mock_model(Message)
      Message.stub(:new).and_return(message)
      message.should_receive(:save)
      post :create
    end
    it "redirects to the Messages index" do
      post :create
      response.should redirect_to(:action => "index")
    end
  end
end
