class Api::UserEventsController < ApplicationController
  before_action :set_user_event, only: [:destroy]

  def create
    event = Event.find(params[:event_id])
    user = User.find(params[:user_id])
    @user_event = UserEvent.create(user: user, event: event)
    json_response(@user_event, :created)
  end

  def destroy
    @user_event.destroy
    head :no_content
  end

  private
  def set_user_event
    @user_event = UserEvent.find(params[:id])
  end
end
