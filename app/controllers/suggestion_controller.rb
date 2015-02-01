class SuggestionController < ApplicationController
	def create
		suggestion = params[:transformation][:suggestion]
		if suggestion.nil?
			flash[:alert] = "Suggestion Failed to Submit, Please Try Again."
			redirect_to game_rules_path
		else
			create_hash = {}
			create_hash[:username] = current_user.username
			create_hash[:suggestion] = suggestion
			Suggestion.create!(create_hash)
			flash[:notice] = "Suggestion Successfully Sent!"
			redirect_to game_rules_path
		end
	end

	def view
		if current_user.is_admin
		  @suggestions = Suggestion.all
		else
			redirect_to game_rules_path
		end
	end

	def delete
		id = params[:id]
		if id.nil?
			flash[:alert] = "Delete Failed, ID was Nil."
			redirect_to view_suggestion_path
		else
			s = Suggestion.find_by_id(id)
			if s.nil?
				flash[:alert] = "Delete Failed: Suggestion Could Not Be Found with ID"
				redirect_to view_suggestion_path
			else
				Suggestion.delete(s)
				flash[:notice] = "Suggestion Successfully Deleted"
				redirect_to view_suggestion_path
			end
		end
	end

	def delete_all_suggestions
		suggestions = Suggestion.all
		suggestions.each do |s|
			Suggestion.delete(s)
		end
		flash[:notice] = "All Suggestions Deleted"
		redirect_to view_suggestion_path
	end
end
