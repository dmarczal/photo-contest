class AddPositionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first, :integer
    add_column :users, :second, :integer
    add_column :users, :third, :integer
  end
end
