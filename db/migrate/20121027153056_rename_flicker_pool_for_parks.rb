class RenameFlickerPoolForParks < ActiveRecord::Migration
  def change
    rename_column :parks, :flicker_pool, :flickr_pool
  end
end
