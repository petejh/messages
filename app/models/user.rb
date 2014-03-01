class User < ActiveRecord::Base
  has_many :received_messages, :class_name => Message.name, :foreign_key => "recipient_id"
  has_many :sent_messages, :class_name => Message.name, :foreign_key => "sender_id"
  
  def send_message(message_attrs)
    sent_messages.create! message_attrs
  end
end
