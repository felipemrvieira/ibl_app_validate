class AddCursoToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :curso, :string
  end
end
