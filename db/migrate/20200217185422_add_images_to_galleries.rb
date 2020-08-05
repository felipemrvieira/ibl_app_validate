class AddImagesToGalleries < ActiveRecord::Migration[5.2]
  def change
    add_column :galleries, :images, :json
  end
end
