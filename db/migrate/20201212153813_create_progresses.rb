class CreateProgresses < ActiveRecord::Migration[6.0]
  def change
    create_table :progresses do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :classroom, null: false
      t.string :activity, null: false
      t.string :result, null: false

      t.timestamps
    end
  end
end
