class AddPropertiesToAttempt < ActiveRecord::Migration[5.2]
  def change
    add_reference :attempts, :quiz_question, foreign_key: true
    add_column :attempts, :hit, :boolean


  end
end
