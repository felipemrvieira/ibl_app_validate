class CreateExam < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.string :title
      t.string :attachment

      t.timestamps
    end
  end
end
