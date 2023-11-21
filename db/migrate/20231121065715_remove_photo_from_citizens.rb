class RemovePhotoFromCitizens < ActiveRecord::Migration[7.1]
  def change
    remove_column :citizens, :photo, :string
  end
end
