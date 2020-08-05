class RenameErrors < ActiveRecord::Migration[5.2]
  def change
    rename_table :errors, :question_errors
  end
end
