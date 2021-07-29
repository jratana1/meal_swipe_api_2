require 'rails/application_controller'

class HomeController < Rails::ApplicationController
  def index
    render file: Rails.root.join('public', 'index.html')
  end

  def verify
    render file:Rails.root.join('public', 'googlecf5e62eac6430738.html')
  end
end