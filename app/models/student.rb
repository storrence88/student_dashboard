class Student < ActiveRecord::Base
  belongs_to :dojo
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, presence: true
  validates :first_name, :last_name, length: { in: 2..15 }
  validates :email, uniqueness: { case_sensitive: false, message: "%{value} already exists" }, format: { with: EMAIL_REGEX, message: "Invalid email address" }
end
