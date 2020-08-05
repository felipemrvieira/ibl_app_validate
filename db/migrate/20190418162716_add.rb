class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :quiz_questions, :order, :integer
  end
end
