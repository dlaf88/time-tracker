@user = User.create(email: "test@test.com",
                    password: "asdfasdf", 
                    password_confirmation: "asdfasdf", 
                    first_name: "Jon", 
                    last_name: "Snow",
                    phone: '1234567891')

puts "1 User created"

AdminUser.create(email: "admin@admin.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "User", last_name: "Admin",phone: '1234567892')

puts "1 Admin User created"

100.times do |post|
	Post.create!(date: Date.today, rationale: "#{post} rationale content", user_id: @user.id, overtime_request: 2.5)
end

puts "100 Posts have been created"

100.times do |audit_log|
	AuditLog.create!(user_id: @user.id , start_date: (Date.today - 6.days), status: 0, end_date: nil)
end

puts "100 Audit Logs have been created"
