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
      render_error(driver, 400)
    end
  end

  def update
    driver = Driver.find(params[:id])
    if driver.update_attributes(@json_params)
      render json: driver, status: 200
    else
      render_error(driver, 400)
    end
  end

  def destroy
    driver = Driver.find(params[:id])
    driver.destroy
    head 204
  end
end
