class DealershipsController < ApplicationController
  before_action :set_dealership, only: [:edit, :update, :show, :destroy]

  def index
    @dealerships = Dealership.all
  end

  def new
    @dealership = Dealership.new
  end

  def create
    @dealership = Dealership.new(dealership_params)
    if @dealership.save
      flash[:success] = 'Dealership Created Succesfully!'
      redirect_to dealership_path
    else
      flash[:error] = 'Fix errors and try again'
      render :new
    end
  end

  def edit
  end

  def update
    if @dealership.update(dealership_params)
      flash[:success] = 'Dealership Updated!'
      redirect_to dealership_path(@dealership)
    else
      flash[:error] = 'Dealership failed to update!'
      render :edit
    end
  end

  def show
  end

  def destroy
    @dealership.destroy
    flash[:success] = 'Dealership Deleted!'
    redirect_to dealerships_path
  end

  private
  def dealership_params
    params.require(:dealership).permit(:name, :amount_of_cars, :second_hand)
  end

  def set_dealership
    @dealership = Dealership.find(params[:id])
  end
end
