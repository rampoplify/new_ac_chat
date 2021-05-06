class CameraJob < ApplicationJob
  queue_as :default

  def perform(r, channel, user)
    ActionCable.server.broadcast "room_channel_#{channel}", {image: r, user: user}
  end
end
