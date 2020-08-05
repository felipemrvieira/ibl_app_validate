class AddEmailMessageToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :email_message, :string
  end
end
