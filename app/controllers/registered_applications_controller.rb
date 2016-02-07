class RegisteredApplicationsController < ApplicationController
  before_action :set_application, except: [:index, :new, :create]

  def index
    @registered_applications = RegisteredApplication.all
  end

  def show
  end

  def new
    @registered_application = current_user.registered_applications.new
  end

  def create
    @registered_application = current_user.registered_applications.build(registered_application_params)
    if @registered_application.save
      redirect_to @registered_application, notice: 'Application registered!'
    else
      flash[:error] = @registered_application.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    if @registered_application.update_attributes(registered_application_params)
      redirect_to @registered_application, notice: 'Application updated!'
    else
      flash[:error] = 'Oops! try again.'
      render :edit
    end
  end

  def destroy
    if @registered_application.destroy
      redirect_to current_user, notice: 'Application removed!'
    else
      redirect_to :back, error: 'Oops! try again.'
    end
  end

private

  def set_application
     @registered_application = current_user.registered_applications.find(params[:id])
  end

  def registered_application_params
    params.require(:registered_application).permit(:name, :url)
  end
end
