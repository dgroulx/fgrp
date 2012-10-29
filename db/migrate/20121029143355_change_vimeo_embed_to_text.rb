# vimdeo embed's are actually the full URL, not just a video tag, since
# the site actually pulls in video from multiple sources. Some of these
# do not fit into postgres' 255 char limit for string fields.

class ChangeVimeoEmbedToText < ActiveRecord::Migration
  def up
    change_column :parks, :vimeo_embed, :text 
  end

  def down
    change_column :parks, :vimeo_embed, :string
  end
end
