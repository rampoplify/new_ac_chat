class ApplicationController < ActionController::Base
	def set_room
      	@room = Room.find(params[:id])
    end
end
