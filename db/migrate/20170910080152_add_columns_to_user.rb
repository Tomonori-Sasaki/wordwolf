class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :citizen_win, :integer
    add_column :users, :wolf_win, :integer
  end
end
