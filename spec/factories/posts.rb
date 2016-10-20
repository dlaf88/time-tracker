FactoryGirl.define do
  factory :post do    
    date Date.today
    rationale "First Post"
    overtime_request 2.5
    user
  end
  
  factory :second_post, class: "Post" do
    date Date.yesterday
    rationale "Second Post"
    overtime_request 0.5
    user
  end
  factory :post_from_other, class: "Post" do
    date Date.yesterday
    rationale "Third user Post and the Pot."
    overtime_request 8.5
    non_auth_user
  end
end