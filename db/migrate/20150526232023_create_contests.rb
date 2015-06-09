class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string   :title
      t.text     :description
      t.string   :image
      t.datetime :opening_enrollment
      t.datetime :closing_enrollment
      t.datetime :opening
      t.datetime :closing

      t.timestamps null: false
    end
  end
end
