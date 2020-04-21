class ListsController < ApplicationController
	# - "add [item name]"
	# - "remove [item name or item number]"
	# - "show items"

	#POST /api/lists/add_item/
	# {
	#    "phone": "+16500008888",
	#    "item": "My first item"
	# }
	def add_item
		user = User.find_by(phone: params[:phone])

		# Find list. Create List if it doesn't exist.
		if user.lists.empty?
			logger.info "List not found in 'add_item'!"
			list = user.lists.new(name: "My List")
			
			if !list.save
				render :status => 400, :json => {:message => list.errors.full_messages} and return
			end
		else
			logger.info "List found in 'add_item'!"
			list = user.lists.first
		end

		# Get last item.
		if list.items.empty?
			last_seq = 0 # first item in list, seq is should be 1; so this is 0
		else
			item = list.items.last
			last_seq = item.seq
		end

		# Add item
		item = list.items.new(name: params[:item], seq: last_seq+1)

		if item.save
			# Format list for display
			output = format_list_output(list)
			render status: 200, json: { item: item, list: output }
		else
			render :status => 400, :json => {:message => item.errors.full_messages}
		end
	end


	#POST /api/lists/add_item/
	# {
	#    "phone": "+16500008888",
	#    "item": "My first item"
	# }
	def remove_item
		user = User.find_by(phone: params[:phone])

		# Find list
		if user.lists.empty?
			logger.info "List not found in 'remove_item'!"
			render :status => 404, :json => {:message => "This user has no list."} and return
		else
			logger.info "List found in 'remove_item'!"
			list = user.lists.first
		end

		# Find item
		if is_number?(params[:item])
			item = list.items.find_by(seq: params[:item].to_i)
		else
			item = list.items.find_by(name: params[:item])
		end

		# Cannot find item
		if item.nil?
			logger.info "Cannot find item in 'remove_item'!"
			render :status => 404, :json => {:message => "Cannot find item"} and return
		end

		# Delete item and re-sequence list
		if list.items.destroy(item)
			# Update seq column
			list.update_seq_column

			# Format list for display
			output = format_list_output(user.lists.where(id: list.id).first)

			render status: 200, json: { item: item, list: output }
		else
			render :status => 500, :json => {:message => item.errors.full_messages}
		end
	end


	#GET /api/lists/show_items/:phone
	def show_items
		user = User.find_by(phone: params[:phone])

		# Find list
		if user.lists.empty?
			logger.info "List not found in 'show_items'!"
			render :status => 404, :json => {:message => "This user has no list."} and return
		else
			logger.info "List found in 'show_items'!"
			list = user.lists.first
		end

		# Format output
		output = format_list_output(list)

		render status: 200, json: { list: output }
	end

	protected

	def format_list_output(list)
		output = ""

		list.items.each do |i|
			output += i.seq.to_s + ". " + i.name + "\n"
		end

		return output
	end

end