class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :image
      t.string :password_digest
      t.string :uid
      t.string :provider
      t.stirng :token

      t.timestamps null: false
    end
  end
end
