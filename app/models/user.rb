class User < ActiveRecord::Base

	has_many :comments
	has_many :shoes
	
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :first_name, :last_name, presence: true, length: { in: 2..20 }
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }


	before_save do
		self.email.downcase!
		if User.any?
			self.user_level = 1
		else
			self.user_level = 9
		end
	end
	
	has_secure_password

	def admin?
		self.user_level == 9
	end
end