class ParticipationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @participation = @event.participations.build(
      user: current_user,
      comment: params.dig(:comment)
    )

    if @participation.save
      redirect_to @event, notice: "イベントに参加しました"
    else
      redirect_to @event, alert: @participation.errors.full_messages.join(", ")
    end
  end

  def destroy
    @participation = current_user.participations.find(params[:id])
    @event = @participation.event
    @participation.destroy

    redirect_to @event, notice: "参加をキャンセルしました"
  end
end
