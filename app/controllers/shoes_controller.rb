class ShoesController < ApplicationController

	  before_action :signed_in_user, only: [:create]

	def new
		@shoe = Shoe.new
	  	@shoes = Shoe.all
	end

	def create
		if current_user.shoes += [Shoe.new(shoe_params)]
			redirect_to new_shoe_path
		else
			redirect_to shoes, flash: { message: "Upload issue" }
		end
	end

	def show
		@shoe = Shoe.find(params[:id])
		@comment = Comment.new
		@comments = @shoe.comments.order("created_at DESC")
	end

	def destroy
		@shoe = Shoe.find(params[:id])
		@shoe.destroy
		respond_to do |format|
      format.html { redirect_to new_shoe_path }
      format.json { head :no_content }
		end
	end

	def search
		@shoes = Shoe.where("name like ?", "%#{params[:search]}%")
	end

	private

	def shoe_params
		params.require(:shoe).permit(:name, :image)
	end

	def signed_in_user
		redirect_to root_path, notice: "Please sign in" unless signed_in?
	end
end
