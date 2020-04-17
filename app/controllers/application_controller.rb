class ApplicationController < ActionController::Base
	protect_from_forgery prepend: true

	protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json }

	before_action :configure_permitted_parameters, if: :devise_controller?


	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])
	end

	def is_number?(string)
  	true if Float(string) rescue false
	end
end
