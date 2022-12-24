class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests do |t|
      t.string :type_test, null: false, default: 'Exam'
      t.belongs_to :user, foreign_key: true
      t.string :user_answer, null: false, default: "[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]"
      t.string :answer, null: false, default: "[[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]"
      t.integer :end, default: 0
      t.integer :result, default: 0

      t.timestamps
    end
  end
end
