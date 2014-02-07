class GadgetsController < ApplicationController

	before_action :authenticate_user!

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
end