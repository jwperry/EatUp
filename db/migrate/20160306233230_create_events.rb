class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :utc_offset, :limit => 8
      t.string :country
      t.string :city
      t.string :state
      t.integer :distance
      t.text :description
      t.string :name
      t.string :meetup_event_id
      t.integer :time, :limit => 8
      t.string :group
      t.string :status

      t.timestamps null: false
    end
  end
end
