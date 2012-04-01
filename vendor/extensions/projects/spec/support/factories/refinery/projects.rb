
FactoryGirl.define do
  factory :project, :class => Refinery::Projects::Project do
    sequence(:case_name) { |n| "refinery#{n}" }
  end
end

