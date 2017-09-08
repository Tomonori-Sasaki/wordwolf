class ChangeColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :player
    add_column :users, :name, :string
    add_column :users, :image, :string
  end
end
