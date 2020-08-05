class AddActiveToErrolments < ActiveRecord::Migration[5.2]
  def change
    add_column :errolments, :active, :boolean
    add_column :errolments, :expiration, :date
  end
end
