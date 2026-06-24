class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name, null: false, limit: 50
      t.text :description, limit: 2000
      t.string :location, limit: 100
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :events, :start_at
  end
end
