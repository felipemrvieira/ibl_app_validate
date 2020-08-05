class AddDeviseTrackableColumnsToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :sign_in_count, :integer, default: 0, null: false
    add_column :students, :current_sign_in_at, :datetime
    add_column :students, :last_sign_in_at, :datetime
    add_column :students, :current_sign_in_ip, :string
    add_column :students, :last_sign_in_ip, :string
  end
end
