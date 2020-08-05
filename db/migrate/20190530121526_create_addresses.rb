class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :neighborhood
      t.string :number
      t.string :state
      t.string :city
      t.references :unit, foreign_key: true

      t.timestamps
    end
  end
end
