class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :meetup_id
      t.string :status
      t.string :name
      t.string :city
      t.string :state
      t.string :country
      t.string :photo
      t.integer :lat
      t.integer :lon
      t.string :token

      t.timestamps null: false
    end
  end
end
