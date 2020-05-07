class AddPasswordToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_digest, :string
    add_column :users, :image_url, :string
  end
end
