class ChangeVimeoEmbedToString < ActiveRecord::Migration
  def up
    change_column :parks, :vimeo_embed, :string 
  end

  def down
    change_column :parks, :vimeo_embed, :text
  end
end
