class AddPasswordFieldsToUser < ActiveRecord::Migration
  def change
  	rename_column :users, :password, :encrypted_password
  	add_column :users, :salt, :string
  end
end
