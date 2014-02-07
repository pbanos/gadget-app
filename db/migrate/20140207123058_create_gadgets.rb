class CreateGadgets < ActiveRecord::Migration
  def change
    create_table :gadgets do |t|
    	t.string :name
    	t.references :user, index: true
    end
  end
end
