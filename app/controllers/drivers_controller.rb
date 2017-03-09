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

  def destroy
    driver = Driver.find(params[:id])
    driver.destroy
    head 204
  end
end
