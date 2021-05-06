class DeleteImageJob < ApplicationJob
  queue_as :default

  def perform(img)
    FileUtils.rm_rf(Dir.glob("#{Rails.root}/public/cam/#{img}.png"))
  end
end
