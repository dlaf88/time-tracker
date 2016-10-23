require 'rails_helper'

RSpec.describe AuditLog, type: :model do
  before do
       @audit_log = FactoryGirl.create(:audit_log)
     end
   describe 'creation' do       
     it 'can be created' do 
       expect(@audit_log).to be_valid
     end 
   end 
  
  describe 'validations' do
  
    it 'must have user_id association' do
      @audit_log.user_id = nil
      expect(@audit_log).to_not be_valid
    end 
    it 'must have a status' do 
       @audit_log.status = nil
      expect(@audit_log).to_not be_valid
    end 
    it 'must have start_date' do 
       @audit_log.start_date = nil
      expect(@audit_log).to_not be_valid
    end 
    it 'must have a start date from 6 days ago' do
      new_audit_log = AuditLog.create(user_id: User.last.id, status: 0 )
      expect(new_audit_log.start_date).to eq(Date.today - 6.days)
    end
  end 
end
