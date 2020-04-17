class UsersController < ApplicationController

	#POST /api/users/update_name.json
	def update_name
		user = User.find_by_phone(user_params[:phone])

		if user.nil?
			render :status => 404, :json => {:message => "User not found"}
		elsif user.update(first_name: user_params[:first_name])
	    render(status: 202, json: user.to_json)
	  else
	    render :status => 400, :json => {:message => user.errors.full_messages}
	  end
	end

	# GET /api/users/retrieve/:phone
	def retrieve
		user = User.find_by_phone(params[:phone])

		if user
			render status: 200, json: user.to_json
		else
			render status: 404, json: {:error => "User does not exist"}
		end
	end


	private

  def user_params
    params.require(:user).permit(:phone, :email, :first_name, :last_name)
  end
end