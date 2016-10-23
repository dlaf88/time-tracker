FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end
  factory :user do    
    first_name "Jon"
    last_name "Snow"
    email {generate :email}
    password "asdfasdf"
    password_confirmation "asdfasdf"
    phone "1234567891"
  end
  
  factory :admin_user, class: "AdminUser" do
    first_name "Admin"
    last_name "User"
    email {generate :email}
    password "asdfasdf"
    password_confirmation "asdfasdf"
    phone "1234567892"
    
  end
  factory :non_auth_user, class: "User" do
    first_name "Non"
    last_name "Auth"
    email {generate :email}
    password "asdfasdf"
    password_confirmation "asdfasdf"
    phone "1234567893"
    
  end
end