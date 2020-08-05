class CreateBackofficeQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :order
      t.string :description
      t.references :path, foreign_key: true

      t.timestamps
    end
  end
end
