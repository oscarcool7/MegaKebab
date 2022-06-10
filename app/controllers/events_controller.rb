class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_event, only: %i[destroy edit show update]
  after_action :verify_authorized, except: %i[index]

  def create
    @event = current_user.events.build(event_params)
    authorize @event

    if @event.save
      redirect_to @event, notice: I18n.t("controllers.events.created")
    else
      render :new
    end
  end

  def destroy
    authorize @event

    @event.destroy

    redirect_to root_path, notice: I18n.t("controllers.events.destroyed")
  end

  def edit
    authorize @event
  end

  def index
    @events = Event.all
  end

  def new
    @event = current_user.events.build
    authorize @event
  end

  def show
    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
    end

    authorize @event

    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
  rescue Pundit::NotAuthorizedError
    flash.now[:alert] = I18n.t("controllers.events.wrong_pincode") if params[:pincode].present?

    render "password_form"
  end

  def update
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: I18n.t("controllers.events.updated")
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
