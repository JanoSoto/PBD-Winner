class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #Obliga al usuario a estar autenticado para poder acceder a cualquier parte de la app
  #Todas las vistas a las que si se puede acceder sin estar logeado van dentro de los corchetes
  before_action :authenticate_user!, :except => [:index]
  
end
