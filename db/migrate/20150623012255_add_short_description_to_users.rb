class AddShortDescriptionToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :short_description, :string
  end
end
