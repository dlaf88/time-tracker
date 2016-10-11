require 'rails_helper'
RSpec.describe Post, type: :model do
   describe "Creation" do
     before do
       @post = Post.new(date: Date.today, rationale: "I want some overtime.")
     end
     it "can be created" do
       expect(@post).to be_valid
     end
     it "cannot be created withou date or rationale" do
      @post.date= nil
      @post.rationale = nil
      expect(@post).to_not be_valid
     end
   end
end
