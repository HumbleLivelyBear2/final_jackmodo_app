module Refinery
  module Projects
    module Admin
      class ProjectsController < ::Refinery::AdminController

        crudify :'refinery/projects/project',
                :title_attribute => 'case_name', :xhr_paging => true

      end
    end
  end
end
