class AddOptionDescriptionAndCorrectToQuestionOptions < ActiveRecord::Migration[5.2]
  def change
    add_column :question_options, :option_description, :string
    add_column :question_options, :correct, :boolean

  end
end
