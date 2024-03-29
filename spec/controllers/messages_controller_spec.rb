require 'spec_helper'

describe MessagesController do
  describe "POST create" do

    let(:message) { mock_model(Message).as_null_object }
    
    before do
      Message.stub(:new).and_return(message)
    end
    
    it "creates a new message" do
      Message.should_receive(:new).with("text" => "a quick brown fox").and_return(message)
      post :create, :message => { "text" => "a quick brown fox" }
    end

    it "saves the message" do
      message.should_receive(:save)
      post :create
    end

    context "when the message saves successfully" do
      before do
        message.stub(:save).and_return(true)
      end
      
      it "sets a flash[:notice] message" do
        post :create
        flash[:notice].should eq("The message was saved successfully.")
      end
      
      it "redirects to the Messages index" do
        post :create
        response.should redirect_to(:action => "index")
      end
    end
    
    context "when the message fails to save" do
      before do
        message.stub(:save).and_return(false)
      end
      
      it "assigns @message" do
        post :create
        assigns[:message].should eq(message)
      end

      it "renders the new template" do
        post :create
        response.should render_template("new")
      end
    end

  end
end
