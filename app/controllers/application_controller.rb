class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
 

  #Obliga al usuario a estar autenticado para poder acceder a cualquier parte de la app
  #Todas las vistas a las que si se puede acceder sin estar logeado van dentro de los corchetes
  before_action :authenticate_user!, :except => [:index]
  protected
  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username,:email,:password,:password_confirmation)}
  end 		  
end
