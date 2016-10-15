require 'rails_helper'

describe 'navigate' do 
  
  describe 'index page' do
    before do
      @user = User.create(email: 'admin@admin.com',password: 'asdfasdf',password_confirmation: 'asdfasdf',first_name: 'Jon',last_name:'Snow')
      login_as(@user, :scope => :user)  
       visit posts_path
    end
    it 'can be reached successfully' do       
      expect(page.status_code).to eq(200)
    end
    it 'has title' do      
      expect(page).to have_content(/Posts/)
    end
    it 'has a Post list' do
      post1 = Post.create(:date => Date.today, :rationale => 'Post1', user_id: @user.id)
      post2 = Post.create(:date => Date.today, :rationale => 'Post2', user_id: @user.id)
      visit posts_path
      expect(page).to have_content(/Post1|Post2/)
    end
  end
  
  describe 'creation' do  
    before do      
      user = User.create(email: 'test@test.com',password: 'asdfasdf',password_confirmation: 'asdfasdf',first_name: 'Jon',last_name:'Snow')
     login_as(user, :scope => :user)     
      visit new_post_path
    end
    it 'has a new form that can be reached' do      
       expect(page).to have_content("New Posts.")
    end
    it 'has a form that can be filled out' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Some rationale.'
      click_on 'Save'          
      expect(page).to have_content("Some rationale.")
    end
    
    it 'has form that can be filled out with an associated user' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'I created this post.'
      click_on 'Save'           
      expect(User.last.posts.last.rationale).to eq("I created this post.")      
    end 
  end
end
