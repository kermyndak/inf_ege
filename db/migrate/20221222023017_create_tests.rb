class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests do |t|
      t.string :type_test, null: false, default: 'Exam'
      t.belongs_to :user
      t.time :time_start, null: false
      t.string :answer, null: false, default: "[[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]"

      t.timestamps
    end
    add_index :tests, :test_id, unique: true
  end
end
