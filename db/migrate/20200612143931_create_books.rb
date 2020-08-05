class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :attachment
      t.string :cover
      t.boolean :downloadable
      t.references :level, foreign_key: true

      t.timestamps
    end
  end
end
