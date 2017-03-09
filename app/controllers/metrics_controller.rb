class MetricsController < ApplicationController
  before_action :load_driver

  def index
    metrics = @metrics_rel.page(params[:page] ? params[:page][:number] : 1)
    render json: metrics
  end

  def show
    metric = @metrics_rel.find(params[:id])
    render json: metric
  end

  def create
    metric = @metrics_rel.new(@json_params)
    if metric.save
      render json: metric, status: 201
    else
      render_error(metric, 400)
    end
  end

  def update
    metric = @metrics_rel.find(params[:id])
    if metric.update_attributes(@json_params)
      render json: metric, status: 200
    else
      render_error(metric, 400)
    end
  end

  def destroy
    metric = @metrics_rel.find(params[:id])
    metric.destroy
    head 204
  end

  private

  def load_driver
    @driver = Driver.find(params[:driver_id]) if params[:driver_id]
    @metrics_rel = @driver ? @driver.metrics : Metric
  end
end
