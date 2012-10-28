class AddParksAliveToParks < ActiveRecord::Migration
  def change
    remove_column :parks, :contact_info
    remove_column :parks, :contact_email
    remove_column :parks, :section
    add_column :parks, :is_parks_alive, :boolean
    add_column :parks, :parks_alive_content, :text
    add_column :parks, :parks_alive_contact, :string
  end
end
