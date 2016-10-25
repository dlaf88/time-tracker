class PostPolicy < ApplicationPolicy
def approve?
  admin?
end 
  
def update?
  # if
  return true if admin? && post_approved?
  return true if admin_or_user && !post_approved?
   
end

private
 def post_approved?
   record.approved?
 end  
  
  def admin?
    admin_types.include?(user.type)
  end 
  def admin_or_user
    record.user_id == user.id || admin?
  end 
  
end