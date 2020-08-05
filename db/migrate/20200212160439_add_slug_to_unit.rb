class AddSlugToUnit < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :slug, :string
    add_index :units, :slug, unique: true
  end
end
