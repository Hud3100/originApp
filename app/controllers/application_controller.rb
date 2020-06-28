class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def set_search
    @search = Micropost.ransack(params[:q])
    @microposts = @search.result
  end

  protected

  def devise_parameter_sanitizer
    if resource_class == Company
      Company::ParameterSanitizer.new(Company, :company, params)
    else
      super
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end

class Company::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:name, :profile])
  end
end