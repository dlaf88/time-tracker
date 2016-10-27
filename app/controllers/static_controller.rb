class StaticController < ApplicationController
  def home
      if admin_user?.include?(current_user.type)
      @pending_posts = Post.submitted
      @recent_audit_items = AuditLog.last(10)
      else 
       @pending_audit_confirmations = current_user.audit_logs
      end 
  end 
end