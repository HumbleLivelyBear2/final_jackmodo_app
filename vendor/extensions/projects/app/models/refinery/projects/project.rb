module Refinery
  module Projects
    class Project < Refinery::Core::BaseModel
      self.table_name = 'refinery_projects'      
    
      acts_as_indexed :fields => [:case_name, :case_title, :case_gist, :case_type, :designer_name, :designer_gist, :designer_web_link, :designer_fb_link, :start_date]

      validates :case_name, :presence => true, :uniqueness => true
          
      belongs_to :case_samll_photo, :class_name => '::Refinery::Image'
    
      belongs_to :case_promote_photo, :class_name => '::Refinery::Image'
    
      belongs_to :designer_photo, :class_name => '::Refinery::Image'
        
    end
  end
end
