class CommentsController < ApplicationController

	before_action :signed_in_user, only:[:create]

	def create
		if Shoe.find(params[:shoe_id]).comments += [current_user.comments.new(comment_params)]
			redirect_to shoe_path(params[:shoe_id])
		else
			redirect_to shoe_path(params[:shoe_id]), flash: { message: "Comment must be two characters" }
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:comment)
	end

	def signed_in_user
		redirect_to root_path, notice: "Please sign in" unless signed_in?
	end
end