class AddColumnStatusEnum < ActiveRecord::Migration
  def change
    add_column :participants, :status, :integer, default: 0
  end
end
