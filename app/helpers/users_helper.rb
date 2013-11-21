module UsersHelper
	def admin?
		@current_user.user_level == 9
	end
end
