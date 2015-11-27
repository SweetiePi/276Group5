class AddDropboxColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :dropbox_token, :string
    add_column :users, :dropbox_secret, :string
    add_column :users, :dropbox_uid, :string, unique: true
  end
end
