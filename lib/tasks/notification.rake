namespace :notification do
  desc "Sends notification to employees asking them to log if they have overtime or not"
  task sms: :environment do
    puts "I am in a rake task."
  end

end
