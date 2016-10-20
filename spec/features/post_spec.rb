require 'rails_helper'

describe 'navigate' do 
    before do
      @user = FactoryGirl.create(:user)
      login_as(@user, :scope => :user)  
    end  
  describe 'index page' do
    before do     
      visit posts_path
    end
    it 'can be reached successfully' do       
      expect(page.status_code).to eq(200)
    end
    it 'has title' do      
      expect(page).to have_content(/Posts/)
    end
    it 'has a Post list' do
     
     post = Post.create(date: Date.today,rationale: "This is the new rationale.",user_id: @user.id)
     post2 = Post.create(date: Date.today,rationale: "This is the other post.",user_id: @user.id)
     other_user = User.create(first_name: 'Ken',last_name: 'Bone',email: 'svengoolie@gmail.com',password: 'asdfasdf',password_confirmation: 'asdfasdf')
     post3 = Post.create(date: Date.today,rationale: "Do not see me.",user_id: other_user.id)
     
     visit posts_path
     expect(page).to_not have_content(/Do not see me./)
    
    end
  end
  describe 'new' do
    it 'has a link from the homepage' do 
      visit root_path
      click_link ("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end 
  end
  describe 'delete' do
    it 'can be deleted' do
      post = Post.create(date: Date.today,rationale: "This is the new rationale.",user_id: @user.id)
      visit posts_path
      
      click_link ("delete_post_#{post.id}")
      expect(page.status_code).to eq(200)
    end 
  end 
  
  describe 'creation' do  
    before do      
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
  describe 'edit' do 
    before do 
     
      @edit_user = User.create(first_name: 'Ken',last_name: 'Bone',email: 'svengoolie@gmail.com',password: 'asdfasdf',password_confirmation: 'asdfasdf')
      login_as(@edit_user,scope: :user)
      @edit_post = Post.create(date: Date.today, rationale: "Hey Jessie", user_id: @edit_user.id)
    end
   
    it 'can be edited ' do 
      visit edit_post_path(@edit_post)
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Some other rationale'
      click_on 'Save'
      
      expect(page).to have_content("Some other rationale")
    end 
    it 'cannot be edited by non authorized user' do
      logout(@edit_user)
      login_as(@user)
      visit edit_post_path(@edit_post)      
      expect(current_path).to eq(root_path)
    end
  end
end
