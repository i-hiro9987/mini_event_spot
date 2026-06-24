class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]
  before_action :authorized_event!, only: [ :edit, :update, :destroy ]

  def index
    @events = Event.upcoming.includes(:user)
  end

  def show
    @participations = @event.participations.includes(:user)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: "イベントを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "イベントを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "イベントを削除しました"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authenticate_user!
    unless logged_in?
      redirect_to root_path, alert: "ログインしてください"
    end
  end

  def authorized_event!
    unless @event.created_by?(current_user)
      redirect_to events_path, alert: "権限がありません"
    end
  end

  def event_params
    params.require(:event).permit(:name, :description, :location, :start_at, :end_at)
  end
end
