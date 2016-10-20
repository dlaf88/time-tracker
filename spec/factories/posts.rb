FactoryGirl.define do
  factory :post do    
    date Date.today
    rationale "First Post"
    user
  end
  
  factory :second_post, class: "Post" do
    date Date.yesterday
    rationale "Second Post"
    user
  end
  factory :post_from_other, class: "Post" do
    date Date.yesterday
    rationale "Third user Post and the Pot."
    non_auth_user
  end
end