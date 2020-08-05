class CreateDiscountMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :discount_messages do |t|
      t.string :nome
      t.string :email
      t.string :telefone
      t.string :unidade
      t.string :curso

      t.timestamps
    end
  end
end
