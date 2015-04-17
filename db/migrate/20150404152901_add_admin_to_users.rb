class AddAdminToUsers < ActiveRecord::Migration
  def change
     # drop_table :AddAdminToUsers
     add_column :users, :admin, :boolean, default: false
  end
end
