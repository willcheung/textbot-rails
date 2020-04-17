# require 'rails_helper'

# describe "get wait time route", :type => :request do

# 	headers = {
# 	    "ACCEPT" => "application/json",     # This is what Rails 4 accepts
# 	    "HTTP_ACCEPT" => "application/json" # This is what Rails 3 accepts
# 	  }

# 	before {get '/api/users/get_wait_time/+16504835977', :headers => headers}

# 	it 'returns wait time' do
# 			pp JSON.parse(response.body)
# 	    expect(JSON.parse(response.body)["wait_time"]).to eq(20)
# 	  end

# 	it 'returns status code 200' do
# 	    expect(response).to have_http_status(:success)
#   end
# end