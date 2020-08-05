class AddPhoneToStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :phone, :string

  end
end
