class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  http_basic_authenticate_with name: QebaParking.config[:basic_auth_key], password: QebaParking.config[:basic_auth_password]
end
