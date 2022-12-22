class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :number, null: false
      t.string :formulation, null: false, default: ''
      t.string :path_image
      t.string :file
      t.string :answer, null: false
      t.integer :part, null: false, default: 1

      t.timestamps
    end
  end
end
