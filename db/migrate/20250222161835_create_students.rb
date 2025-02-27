class CreateStudents < ActiveRecord::Migration[7.2]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :surname
      t.references :school, null: false, foreign_key: true
      t.references :class, null: false, foreign_key: { to_table: :classes }

      t.timestamps
    end
  end
end
