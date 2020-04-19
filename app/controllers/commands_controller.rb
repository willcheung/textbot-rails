class CommandsController < ApplicationController

##### List of commands #####
# Show items
# Add [item name]
# Remove [item name]
# Remove [item number]
# Share list with [number]
#############################

	#POST /api/commands/trigger_mylist/
	# {
	#    "message":"show items"
	# }
	def trigger_mylist
		# Define trigger keywords
		show_items_trigger = "show items"
		add_item_trigger = "add "
		remove_item_trigger = "remove "

		client = Twilio::REST::Client.new
		user = User.find_by_phone(params[:phone])
		# Lower case all keywords for comparison
		command = params[:message].to_s.downcase

		if user
			# If user exsits, parse command
			case
			when command.starts_with?(show_items_trigger)
				logger.info "Calling Show Items Flow"
				execution = client.studio
                   .v1
                   .flows('FWxxxxxxxxxx-show-items')
                   .executions
                   .create(parameters: {phone: params[:phone]}, to: params[:phone], from: ENV['TWILIO_PHONE_NUMBER'])
			
			when command.starts_with?(add_item_trigger)
				item = command.sub!(add_item_trigger, "")

				logger.info "Calling Add Item Flow"
				execution = client.studio
                   .v1
                   .flows('FWxxxxxxxxxx-add-item')
                   .executions
                   .create(parameters: {phone: params[:phone], item: item}, to: params[:phone], from: ENV['TWILIO_PHONE_NUMBER'])

      when command.starts_with?(remove_item_trigger)
				item = command.sub!(remove_item_trigger, "")

				logger.info "Calling Remove Item Flow"
				execution = client.studio
                   .v1
                   .flows('FWxxxxxxxxxx-remove-item')
                   .executions
                   .create(parameters: {phone: params[:phone], item: item}, to: params[:phone], from: ENV['TWILIO_PHONE_NUMBER'])

			else
				# Send generic message about valid commands. "Hi" becomes just a generic command
				message = client.messages
				  .create(
				     body: "Welcome back #{user.first_name}! Things you can do:\n" + 
										"- add [item name to list]\n" +
										"- remove [item name or item number]\n" +
										"- show items",
				     from: ENV['TWILIO_PHONE_NUMBER'],
				     to: user.phone
				   )

				logger.info "Unrecognized command #{command}. Sent a generic message."
				render status: 400, json: {message: "Unrecognized command. Sent a generic message."} and return
			end


			logger.info "Twilio Flow " + execution.sid + " excuted!"
			render status: 200, json: {message: params[:message] + " command executed."}
		
		else
			# Shouldn't come here b/c Flow checks user existence
		  render status: 404, json: {:message => "Can't find user."}
		end
	end

end