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
end