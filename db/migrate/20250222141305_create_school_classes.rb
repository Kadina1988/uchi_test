class CreateSchoolClasses < ActiveRecord::Migration[7.2]
  def change
    create_table :classes do |t|
      t.integer :number
      t.string :letter
      t.integer :students_count
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end
