class GadgetsController < ApplicationController

	before_action :authenticate_user!

	def index
		@gadgets = current_user.gadgets
	end

	def new
		@gadget = Gadget.new
	end

	def create
		@gadget = current_user.gadgets.build(name: params[:gadget][:name])
		if @gadget.save
			redirect_to root_path
		else
			render :new
		end
	end

	def search
		@query = params[:q]
		@gadgets = Gadget.search(current_user, @query)
	end

	def edit
		@gadget = current_user.gadgets.find(params[:id])
	end

	def update
		@gadget = current_user.gadgets.find(params[:id])
		if @gadget.update_attributes(name: params[:gadget][:name])
			redirect_to root_path
		else
			render :edit
		end
	end

	def destroy
		@gadget = current_user.gadgets.find(params[:id])
		@gadget.destroy
		redirect_to root_path
	end
end