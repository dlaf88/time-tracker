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
      post1 = FactoryGirl.create(:post)
      post2 = FactoryGirl.create(:second_post)
      visit posts_path
      expect(page).to have_content(/First Post|Second Post/)
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
       @post = FactoryGirl.create(:post)
    end
    it 'can be reached by clicking edit on index page' do      
      visit posts_path
      click_link("edit_#{@post.id}")
      expect(page.status_code).to eq(200)
    end
    it 'can be edited ' do 
      visit edit_post_path(@post)
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Some other rationale'
      click_on 'Save'
      
      expect(page).to have_content("Some other rationale")
    end 
  end
end
