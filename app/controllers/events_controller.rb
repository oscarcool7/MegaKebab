class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_event, only: %i[show]
  before_action :set_current_user_event, only: %i[edit destroy update]

  def create
   @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: "Event was successfully created."
    else
      render :new
    end
  end

  def destroy
    @event.destroy

    redirect_to root_path, notice: "Event was successfully destroyed."
  end

  def edit
  end

  def index
    @events = Event.all
  end

  def new
    @event = current_user.events.build
  end

  def show
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description)
  end

  def set_current_user_event
    @event = current_user.events.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
