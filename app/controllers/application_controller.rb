class ApplicationController < ActionController::API
  before_action :fetch_params, only: [:create, :update]

  private

  def fetch_params
    @json_params = ActiveModelSerializers::Deserialization.jsonapi_parse(JSON.parse(request.body.string))
  end
end
