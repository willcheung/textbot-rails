class RegistrationsController < Devise::RegistrationsController
	respond_to :json


	# POST /api/users/sign_up
	# {
 	#    "user": {
 	#        "phone": "+16500008888"
 	#    }
	# }
	def sign_up
		user = User.find_by_phone(user_params[:phone])

		if user
			render status: 200, json: user.to_json
		else
			user = User.new(user_params)

		  if user.save
		    render status: 200, json: user.to_json
		  else
		    render :status => 500, :json => {:message => user.errors.full_messages}
		  end
		end
	end


	private

	def user_params
    params.require(:user).permit(:phone, :email, :first_name, :last_name)
  end
end