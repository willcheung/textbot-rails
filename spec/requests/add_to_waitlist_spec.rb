# require 'rails_helper'

# describe "add to list", :type => :request do

# 	headers = {
# 	    "ACCEPT" => "application/json",     # This is what Rails 4 accepts
# 	    "HTTP_ACCEPT" => "application/json" # This is what Rails 3 accepts
# 	  }

# 	before {get '/api/users/get_wait_time/+16504835977', :headers => headers}

#   it 'adds existing user to list successfully' do
# 			pp JSON.parse(response.body)
	    
# 	    expect(JSON.parse(response.body)["wait_time"]).to eq(20)
# 	    expect(response).to have_http_status(:success)
# 	  end

# 	it 'adds existing user to an invalid list' do
#   end

#   it 'creates and adds new user to list successfully' do
#   end

#   it 'creates and adds new user to invalid waitlist' do  
#   end

# end