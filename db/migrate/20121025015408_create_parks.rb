class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
      t.string :name
      t.text :history
      t.float :latitude
      t.float :longitude
      t.text :contact_info
      t.decimal :park_size
      t.text :address
      t.text :vimeo_embed
      t.string :flicker_pool
      t.string :section

      t.timestamps
    end
  end
end
