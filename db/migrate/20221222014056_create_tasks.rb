class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :number, null: false
      t.string :formulation, null: false
      t.string :answer, null: false
      t.integer :part, null: false, default: 1

      t.timestamps
    end
    add_index :tasks, :number, unique: true
  end
end
