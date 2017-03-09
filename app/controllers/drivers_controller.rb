class DriversController < ApplicationController
  def show
    driver = Driver.find(params[:id])
    render json: driver
  end

  def create
    driver = Driver.new(@json_params)
    if driver.save
      render json: driver, status: 201
    else
      head 400
    end
  end
end
