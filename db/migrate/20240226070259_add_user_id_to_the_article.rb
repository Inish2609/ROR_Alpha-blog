class AddUserIdToTheArticle < ActiveRecord::Migration[7.1]
  def change
    add_column :articles,:user_id,:int
  end
end
