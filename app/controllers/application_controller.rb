class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def set_host
    Rails.env.production? ? 'production_url' : 'localhost:3000'
  end

end
