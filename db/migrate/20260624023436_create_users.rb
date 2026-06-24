class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :uid
      t.string :image_url

      t.timestamps
    end

    add_index :users, [ :provider, :uid ], unique: true
  end
end
