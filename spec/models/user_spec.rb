require 'rails_helper'

RSpec.describe User, type: :model do
      before do
      @user = FactoryGirl.create(:user)
    end
  describe "creation" do
    it 'can be created' do
      expect(@user).to be_valid
    end
  end
  describe "validation" do 
     it 'cannot be created without names' do
      @user.first_name = nil
      @user.last_name = nil
      expect(@user).to_not be_valid
    end
    it 'cannot be created without a phone' do
      @user.phone = nil 
      expect(@user).to_not be_valid
    end 
    
    it 'phone attr must be composed of integers ' do 
      @user.phone = 'mygreatstr'
      expect(@user).to_not be_valid
    end 
     it 'phone attr must be 10 characters long ' do 
      @user.phone = '12345678910111'
      expect(@user).to_not be_valid
    end 
  end 
  describe "custom name methods" do
  it 'has a full name method that combines first and last name' do
      expect(@user.full_name).to eq("SNOW, JON")
  end 
  end
end
