class CreateParkLinks < ActiveRecord::Migration
  def change 
    create_table :park_links do |t|
      t.string :name
      t.string :url
      t.integer :park_id

      t.timestamps
    end
  end
end
