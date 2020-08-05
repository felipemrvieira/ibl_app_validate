class AddAudioVersionToAudio < ActiveRecord::Migration[5.2]
  def change
    add_reference :audios, :audio_version, foreign_key: true
  end
end
