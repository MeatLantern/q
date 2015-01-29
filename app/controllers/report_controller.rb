class ReportController < ApplicationController

	def admin
		#Report::destroy_old_reports
		if current_user.is_admin
			@reports = Report.all
		else
			redirect_to game_rules_path
		end

	end

	def destroy
		@report = Report.find_by_id(params[:id])
		if @report.nil?
			flash[:alert] = "The Report Could Not Be Found."
			redirect_to admin_report_path
		end
		Report.delete(@report)
		flash[:notice] = "Report Successfully Deleted."
		redirect_to admin_report_path		
	end

	def edit
		@report = Report.find_by_id(params[:id])
		if @report.nil?
			flash[:alert] = "The Report Could Not Be Found."
			redirect_to admin_report_path
		end
	end

	def change
		report = Report.find_by_id(params[:id])
		if report.nil?
			flash[:alert] = "The Report Could Not Be Found."
			redirect_to admin_report_path
		end
		tf = params["transformation"]
		feedback = tf["feedback"]
		update_hash = {}
		update_hash[:feedback] = feedback
		update_hash[:resolved] = true
		report.update_attributes(update_hash)
		report.save
		flash[:notice] = "Report Successfully Resolved"
		Report::destroy_old_reports
		redirect_to admin_report_path
	end
	
	def create_report
		c = params[:name]
		if c.nil?
			flash[:alert] = "The Character for this Report has Not Been Found. Please Try again."
			redirect_to game_rules_path
		end
		@character = Character.find_by_name(c)

		x = session["warden.user.user.key"]
    	y = User.find(x[0])
    	z = y[0]
    	@username = z["username"]
	end

	def send_report
		create_hash = {}
		tf = params["transformation"]
		create_hash["character_name"] = params["character_name"]
		create_hash["character_creator"] = params["creator"]
		create_hash["reporter"] = params["reporter"]
		create_hash["report"] = tf["Report"]
		create_hash["resolved"] = false
		create_hash["feedback"] = "Not Resolved Yet"
		#Create Reasons String
		reasons = ""
		if (tf["tf_tags"] == "1")
			reasons = reasons + " Tf Tags"
		end
		if (tf["complete"] == "1")
			reasons = reasons + " Not Complete"
		end
		if (tf["adult"] == "1")
			reasons = reasons + " Adult"
		end
		if (tf["full_picture"] == "1")
			reasons = reasons + " Fully Illustrated"
		end
		if (tf["cheating"] == "1")
			reasons = reasons + " Cheating"
		end
		if (tf["obscene"] == "1")
			reasons = reasons + " Obscene"
		end
		if (tf["other"] == "1")
			reasons = reasons + " Tf Tags"
		end
		create_hash["reasons"] = reasons
		Report.create!(create_hash)
		redirect_to game_rules_path
	end
end
