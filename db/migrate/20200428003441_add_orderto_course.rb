class AddOrdertoCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :order, :integer
  end
end
