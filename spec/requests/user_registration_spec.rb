require 'rails_helper'

describe "register user", :type => :request do

	headers = {
	    "ACCEPT" => "application/json",     # This is what Rails 4 accepts
	    "HTTP_ACCEPT" => "application/json" # This is what Rails 3 accepts
	  }

	before do
		post '/api/users/sign_up.json', :headers => headers, params: 
		{
		    "user": {
		        "phone": "+16504838888",
		        "first_name": "Donald",
		        "last_name": "Duck"
		    }
		}
	end

	it 'signs up user with phone number' do
		expect(JSON.parse(response.body)["phone"]).to eq("+16504835977")
		expect(JSON.parse(response.body)["first_name"]).to eq("Will")
		expect(JSON.parse(response.body)["last_name"]).to eq("Cheung")
		expect(response).to have_http_status(:success)
	end

	it 'updates the name' do
		post "/api/users/update_name.json", params:
		{
		    "user": {
		        "phone": "+165048358888",
		        "first_name": "Daisy"
		    }
		}

		expect(response.status).to eq(202)
		expect(User.find_by_phone("+16504835977").first_name).to eq("Henry")
	end

end