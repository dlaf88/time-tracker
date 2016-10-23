class User < ActiveRecord::Base
  has_many :posts
  has_many :audit_logs
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :first_name, :last_name, :phone  
  REGEX = /\A[0-9]*\Z/
  validates_format_of :phone, with: REGEX
  validates :phone, length:{is: 10}
  def full_name
    "#{last_name.upcase}" + ', ' + "#{first_name.upcase}"
  end
end
