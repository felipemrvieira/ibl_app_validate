class AddTypeToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :type_question, :string
  end
end
