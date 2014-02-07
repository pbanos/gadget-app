class GadgetImagesController < ApplicationController

	before_action :authenticate_user!

	def create
		@gadget = current_user.gadgets.find(params[:gadget_id])
		@gadget_image = @gadget.gadget_images.build(params.require(:gadget_image).permit(:attachment))
		@gadget_image.save
		redirect_to edit_gadget_path(@gadget)
	end

	def destroy
		@gadget = current_user.gadgets.find(params[:gadget_id])
		@gadget_image = @gadget.gadget_images.find(params[:id])
		@gadget_image.destroy
		redirect_to edit_gadget_path(@gadget)
	end

end