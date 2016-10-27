namespace :notification do
  desc "Sends notification to employees asking them to log if they have overtime or not"
  task sms: :environment do
    puts "I am in a rake task."
  end
  
  desc "Sends email to managers each day to inform them of overtime requests"
  task manager_email: :environment do
    posts = Post.submitted
    admin_users = AdminUser.all
    if posts.count > 0 
      admin_users.each do |admin|
        ManagerMailer.email(admin).deliver_later
      end 
    end 
  end

end
