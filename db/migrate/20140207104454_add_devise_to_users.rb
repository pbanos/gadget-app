class AddDeviseToUsers < ActiveRecord::Migration
  def change
  	change_table(:users) do |t|
  		t.string :encrypted_password, :null => false, :default => ""
  	end
  	add_index :users, :username, :unique => true
  end
end
