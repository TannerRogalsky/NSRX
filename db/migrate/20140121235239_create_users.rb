class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null => false
      t.string :notification_token
      t.string :thumbnail
      t.integer :record, :default => 0

      t.timestamps
    end
  end
end
