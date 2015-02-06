class MessageController < ApplicationController

	def view_all_messages
		search_hash = {}
		search_hash[:receiver] = current_user.username
		@messages = Message.where(search_hash)
		@messages = @messages.order("created_at DESC")
		search_hash = {}
		search_hash[:sender] = current_user.username
		@sent_messages = Message.where(search_hash)
	end

	def create_message
		@sender = current_user.username
		if ! (params[:reciever].nil?)
			@receiver = params[:receiver]
		end
		if !(params[:old_subject]).nil?
			@old_subject = params[:old_subject]
		end
		@reply_content = params[:reply_content]

	end

	def send_message
		create_hash = {}
		create_hash[:sender] = params[:sender]
		create_hash[:receiver] = params[:receiver]
		create_hash[:subject] = params[:transformation][:subject]
		create_hash[:message] = params[:transformation][:message]
		create_hash[:is_read] = false
		#Check if Receiver Exists and if it is a Friend
		rec = User.find_by_username(create_hash[:receiver])
		if rec.nil?
			flash[:alert] = "The Message Could Not Be Sent. The Receiver was not found."
			redirect_to view_all_messages_path
		else
			if current_user.friends_list.include?(create_hash[:receiver])
				create_hash[:is_friend] = true
			else
				create_hash[:is_friend] = false
			end
			Message.create!(create_hash)
			flash[:notice] = "Message Sent"
			redirect_to view_all_messages_path
		end
	end

	def delete_message
		id = params[:id]
		message = Message.find_by_id(id)
		if message.nil?
		flash[:alert] = "The Message you Wanted to Delete Could Not Be Found."
		redirect_to view_all_messages_path
		else
			Message.delete(message)
		end
	end

	def edit_message
		@message = Message.find_by_id(params[:id])
		if @message.nil?
			flash[:alert] = "The Message Could Not Be Found."
			redirect_to view_all_messages_path
		else
			@reply_content = @message.message
		end
	end

	def view_message
		@message = Message.find_by_id(params[:id])
		if @message.nil?
			flash[:alert] = "The Message Could Not Be Found."
			redirect_to view_all_messages_path
		else
			@message.is_read = true
			@message.save
		end
	end

end
