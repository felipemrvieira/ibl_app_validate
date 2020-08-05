class CreateErrolments < ActiveRecord::Migration[5.2]
  def change
    create_table :errolments do |t|
      t.references :student, foreign_key: true
      t.references :level, foreign_key: true

      t.timestamps
    end
  end
end
