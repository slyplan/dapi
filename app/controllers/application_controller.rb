class ApplicationController < ActionController::API
  before_action :fetch_params, only: [:create, :update]
  before_action :check_headers, only: [:create, :update]

  private

  def fetch_params
    @json_params = ActiveModelSerializers::Deserialization.jsonapi_parse(JSON.parse(request.body.string))
  end

  def check_headers
    if request.content_type != "application/vnd.api+json"
      head 406 and return
    end
  end
end
