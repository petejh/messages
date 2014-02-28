class MessagesController < ApplicationController
  def create
    message = Message.new(params[:message])
    message.save
    redirect_to :action => "index"
  end
end
