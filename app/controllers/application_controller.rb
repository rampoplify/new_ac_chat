class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	def set_room
      	@room = Room.find(params[:id])
    end
end
