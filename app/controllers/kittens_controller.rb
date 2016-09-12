class KittensController < ApplicationController

	def index
		@kittens = Kitten.all

		respond_to do |format|
			format.html
			format.json { render json: @kittens.to_json }
		end
	end

	def new
		@kitten = Kitten.new
	end

	def create
		@kitten = Kitten.new(kitten_params)
		if @kitten.save
			flash[:success] = "Meow, you just created a new kitten!"
			redirect_to kitten_path(@kitten.id)
		else
			render 'new'
		end
	end

	def show
		@kitten = Kitten.find(params[:id])

		respond_to do |format|
			format.html
			format.json { render json: @kitten.to_json}
		end
	end

	def edit
		@kitten = Kitten.find(params[:id])
	end

	def update
		@kitten = Kitten.find(params[:id])
		if @kitten.update_attributes(kitten_params)
			flash[:success] = "Meow, your kitten has been updated!"
			redirect_to kitten_path(@kitten.id)
		else
			render 'edit'
		end
	end

	def destroy
		Kitten.find(params[:id]).destroy
		flash[:notice] = "Meow, your kitten was deleted"
		redirect_to kittens_url
	end	

	private

		def kitten_params
			params.require(:kitten).permit(:name, :age, :cuteness, :softness)
		end
end
