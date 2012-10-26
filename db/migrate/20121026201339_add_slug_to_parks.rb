class AddSlugToParks < ActiveRecord::Migration
  def change
    add_column :parks, :slug, :string
  end
end
