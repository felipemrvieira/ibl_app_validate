class AddLevelToAudio < ActiveRecord::Migration[5.2]
  def change
    add_reference :audios, :level, foreign_key: true
  end
end
