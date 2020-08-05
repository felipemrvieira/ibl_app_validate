class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :nome
      t.string :email
      t.string :telefone
      t.string :unidade
      t.string :assunto
      t.text :corpo

      t.timestamps
    end
  end
end
