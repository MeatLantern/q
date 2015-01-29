class Report < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected

  def Report::destroy_old_reports
    reports = Report.all
    reports.each do |r|
      if r.updated_at < 3.day.ago
        if r.resolved == true
        	Report.delete(r)
        end
      end
    end
  end

end
