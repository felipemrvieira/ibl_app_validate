class AddSiteAndPhoneToUnit < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :site, :string
    add_column :units, :phone, :string
  end
end
