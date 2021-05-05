class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    sender = ApplicationController.render(
    	partial: 'messages/sender', 
    	locals: { message: message }
    )
    receiver = ApplicationController.render(
    	partial: 'messages/receiver', 
    	locals: { message: message }
    )
    ActionCable.server.broadcast "room_channel_#{message.room_id}", {message: message, sender: sender, receiver: receiver}
  end
end
