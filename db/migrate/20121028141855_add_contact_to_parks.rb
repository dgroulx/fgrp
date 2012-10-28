class AddContactToParks < ActiveRecord::Migration
  def change
    add_column :parks, :contact_email, :string
  end
end
