class CreateErrors < ActiveRecord::Migration[5.2]
  def change
    create_table :errors do |t|
      t.references :student, foreign_key: true
      t.references :question, foreign_key: true

      t.string :description, default: "Sem descrição"

      t.timestamps
    end
  end
end
