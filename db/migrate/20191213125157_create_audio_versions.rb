class CreateAudioVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :audio_versions do |t|
      t.string :title
      t.references :level, foreign_key: true

      t.timestamps
    end
  end
end
