class CommentController < ApplicationController

	def view
		@character = Character.find_by_name(params[:name])
		if @character.nil?
			flash[:alert] = "The Character's Comment Page Could Not Be Found"
			redirect_to game_rules_path
		end
		search_hash = {}
		search_hash[:character] = @character.name
		@comments = Comment.where(search_hash)
		#binding.pry
	end

	def create
		name = params[:character_name]
		comment = params["transformation"]["Comment"]
		character = Character.find_by_name(name)
		if character.nil?
			flash[:alert] = "Comment Could Not be Made."
			redirect_to game_rules_path
		else
			create_hash = {}
			create_hash[:character] = character.name
			create_hash[:owner] = character.creator
			create_hash[:comment] = comment
			create_hash[:username] = current_user.username
			create_hash[:flag] = false

			Comment.create!(create_hash)

			flash[:notice] = "Comment Successfully Added!"
			redirect_to view_comment_path(:name => character.name)	
		end	
	end

	def edit
		@comment = Comment.find_by_id(params[:id])
		if @comment.nil?
			flash[:alert] = "The Comment could not be found."
			redirect_to game_rules_path
		end
	end

	def delete
		@comment = Comment.find_by_id(params[:id])
		#binding.pry
		if @comment.nil?
			flash[:alert] = "The Comment could not be found."
			redirect_to game_rules_path
		else
			character = @comment.character
			Comment.delete(@comment)
			flash[:notice] = "The Comment has been Successfully Deleted"
			redirect_to view_comment_path(:name => character)
		end
	end

	def admin
		if current_user.is_admin
			search_hash = {}
			search_hash[:flag] = true
			@comments = Comment.where(search_hash)
		else
			redirect_to game_rules_path
		end
	end

	def flag
		@comment = Comment.find_by_id(params[:id])
		#binding.pry
		if @comment.nil?
			flash[:alert] = "The Comment could not be found."
			redirect_to game_rules_path
		else
			if @comment.flag == false
				@comment.flag = true
				@comment.save
				flash[:notice] = "The Comment has Been Successfully Flagged. An Admin will look at it. If the issue is unclear, please send a Report as well. Thanks!"
				redirect_to view_comment_path(:name => @comment.character)
			else
				@comment.flag = false
				@comment.save
				flash[:notice] = "The Comment has Been Successfully Unflagged"
				redirect_to view_comment_path(:name => @comment.character)
			end
		end
	end


	def update
		comment = Comment.find_by_id(params[:id])
		if comment.nil?
			flash[:alert] = "The Comment Could Not be Found"
			redirect_to game_rules_path
		else
			new_text = params["transformation"]["Comment"]
			change_hash = {}
			change_hash[:comment] = new_text
			comment.update_attributes(change_hash)
			redirect_to view_comment_path(:name => comment.character)
		end

	end
end
