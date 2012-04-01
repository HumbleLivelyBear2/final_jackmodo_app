# This migration comes from refinery_projects (originally 1)
class CreateProjectsProjects < ActiveRecord::Migration

  def up
    create_table :refinery_projects do |t|
      t.string :case_name
      t.string :case_title
      t.text :case_gist
      t.integer :case_samll_photo_id
      t.integer :case_promote_photo_id
      t.integer :case_current_money
      t.integer :case_wanted_money
      t.integer :case_price
      t.integer :case_support_people_num
      t.string :case_type
      t.string :designer_name
      t.text :designer_gist
      t.integer :designer_photo_id
      t.string :designer_web_link
      t.string :designer_fb_link
      t.string :start_date
      t.integer :left_days
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-projects"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/projects/projects"})
    end

    drop_table :refinery_projects

  end

end
