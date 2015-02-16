class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CernerOpenidClient::OpenidLoginCanceled, with: :canceled_login
  rescue_from CernerOpenidClient::OpenidLoginFailed, with: :failed_login

  def canceled_login
    redirect_to public_path
  end

  def failed_login(exception)
    render layout: true, text: "Login failed: #{exception.message}"
  end
end
