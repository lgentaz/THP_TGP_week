class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.boolean :liked
      
      t.belongs_to :gossip, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
