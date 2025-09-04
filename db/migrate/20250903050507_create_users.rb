class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.integer :external_id, null: false
      t.string :email
      t.string :name

      # kept user model dry, not adding the extra attributes since they are not needed

      t.timestamps
    end

    add_index :users, :external_id, unique: true
  end
end
