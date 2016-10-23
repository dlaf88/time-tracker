require 'rails_helper'

describe 'Audit Log Feature' do 
  let(:admin_user){FactoryGirl.create(:admin_user)}
  describe 'index' do
    before do
      
      FactoryGirl.create(:audit_log)
      login_as(admin_user,scope: :user)
      visit audit_logs_path
    end 
    it 'has an index action that can be reached' do       
      expect(page.status_code).to eq(200)
    end 
    it 'renders audit log content' do        
      expect(page).to have_content(/SNOW, JON/)
    end 
    xit 'cannot be accessed by regular user' do
    end 
  end  
end 