class CreateGadgetImages < ActiveRecord::Migration
  def change
    create_table :gadget_images do |t|
    	t.references :gadget
    end
    add_attachment :gadget_images, :attachment
  end
end
