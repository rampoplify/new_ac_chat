class CameraJob < ApplicationJob
  queue_as :default

  def perform(r, channel)
    ActionCable.server.broadcast "room_channel_#{channel}", {image: r}
  end
end
