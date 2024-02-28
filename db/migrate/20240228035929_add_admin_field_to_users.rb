class AddAdminFieldToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :Users,:admin,:boolean,default:false
  end
end
