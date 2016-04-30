class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.integer :pass_id
      t.string :name

      t.timestamps null: false
    end
  end
end
