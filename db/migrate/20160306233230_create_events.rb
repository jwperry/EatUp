class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :utc_offset
      t.string :country
      t.string :city
      t.string :zip
      t.string :state
      t.integer :distance
      t.text :description
      t.string :name
      t.integer :meetup_event_id
      t.datetime :time
      t.string :group
      t.string :status

      t.timestamps null: false
    end
  end
end
