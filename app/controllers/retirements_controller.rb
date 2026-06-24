class RetirementsController < ApplicationController
  before_action :authenticate_user!
  def new
    @future_created_events = current_user.events.upcoming
    @future_participated_events = current_user.participated_events.upcoming
  end

  def destroy
    if current_user.events.upcoming.exists? || current_user.participated_events.upcoming.exists?
      redirect_to new_retirement_path, alert: "未開催のイベントがあるため退会できません"
      return
    end

    current_user.destroy
    reset_session
    redirect_to root_path, notice: "退会しました"
  end
end
