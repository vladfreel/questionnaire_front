require 'rest-client'
class RestClientService

  def initialize(params)
    @action = params[:action]
    @params = params[:params]
    @url = params[:url]
  end

  def send_request
    case @action
      when 'post'
        RestClient.post @url, @params , {content_type: :json, accept: :json}
      when 'get'
        RestClient.get @url, {content_type: :json, accept: :json}
      when 'put'
        RestClient.put @url, @params , {content_type: :json, accept: :json}
      when 'delete'
        RestClient.delete @url, { accept: :json }
    end
  end

  private

  attr_reader :action, :params, :url

end