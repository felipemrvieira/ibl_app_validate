class AddAttachmentToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :attachment, :string
  end
end
