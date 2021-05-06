class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  # before_action :set_room, only: %i[ create ]

  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    # respond_to do |format|
      # if @message.save
        @message.save
        # redirect_to request.referrer
        # format.html { redirect_to @message, notice: "Message was successfully created." }
        # format.json { render :show, status: :created, location: @message }
        # format.js {render 'show'}
      # else
      #   format.html { render :new, status: :unprocessable_entity }
      #   format.json { render json: @message.errors, status: :unprocessable_entity }
      # end
    # end

    # html = render(partial: 'messages/message', locals: { message: @message })
    # ActionCable.server.broadcast "room_channel_#{@message.room_id}", {message: html}
    SendMessageJob.perform_later(@message)
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def go_live 
    r= rand(1..1000)
    directory_name = "#{Rails.root}/public/cam/"
    Dir.mkdir(directory_name) unless File.exists?(directory_name)
    DeleteImageJob.set(wait: 2.minutes).perform_later(r)
    # FileUtils.rm_rf(Dir.glob("#{directory_name}*"))
    File.open("#{directory_name}#{r}.png", 'wb') do |f|
      f.write(params[:image].read)
    end
    CameraJob.perform_later(r, params[:channel], current_user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content, :user_id, :room_id)
    end
end
