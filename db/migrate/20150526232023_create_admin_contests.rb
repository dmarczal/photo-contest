class CreateAdminContests < ActiveRecord::Migration
  def change
    create_table :admin_contests do |t|
      t.string   :title
      t.text     :description
      t.string   :folder
      t.datetime :opening_enrollment
      t.datetime :closing_enrollment
      t.datetime :opening
      t.datetime :closing

      t.timestamps null: false
    end
  end
end
