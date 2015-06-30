class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :participant, index: true

      t.timestamps null: false
    end
    add_foreign_key :votes, :users
    add_foreign_key :votes, :participants
  end
end
