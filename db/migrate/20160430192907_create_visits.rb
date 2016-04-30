class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :owner, index: true, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps null: false
    end
  end
end
