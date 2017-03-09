class DriversController < ApplicationController
  def show
    driver = Driver.find(params[:id])
    render json: driver
  end
end
