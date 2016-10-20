require 'rails_helper'

describe 'navigate' do 
  let(:user){FactoryGirl.create(:user)}
  let(:post) do 
    Post.create(date: Date.today, rationale: "Some rationale here.", user_id: user.id, overtime_request: 2.5)
  end 
    before do      
      login_as(user, :scope => :user)  
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
     other_user = User.create(first_name: 'Ken',last_name: 'Bone',email: 'svengoolie@gmail.com',password: 'asdfasdf',password_confirmation: 'asdfasdf')
     post3 = Post.create(date: Date.today,rationale: "Do not see me.",user_id: other_user.id,overtime_request: 2.5)
     
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
      post = Post.create(date: Date.yesterday, rationale: "This is some other post", user_id: user.id,overtime_request: 2.5)
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
      fill_in 'post[overtime_request]', with: 4.5
      
      expect{ click_on 'Save'}.to change(Post,:count).by(1)
    end
    
    it 'has form that can be filled out with an associated user' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'I created this post.'
      fill_in 'post[overtime_request]', with: 4.5
      click_on 'Save'           
      expect(User.last.posts.last.rationale).to eq("I created this post.")      
    end 
  end
  describe 'edit' do 

    it 'can be edited ' do 
      visit edit_post_path(post)
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Some other rationale'
      click_on 'Save'
      
      expect(page).to have_content("Some other rationale")
    end 
    it 'cannot be edited by non authorized user' do
      ken = User.create(first_name: 'Ken', last_name: 'Bone', email: 'svengoolie@gmail.com', password:'asdfasdf',password_confirmation: 'asdfasdf')
      logout(user)
      login_as(ken, scope: :user)
      visit edit_post_path(post)      
      expect(current_path).to eq(root_path)
    end
  end
end
