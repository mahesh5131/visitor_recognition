class CreateVisitors < ActiveRecord::Migration[7.0]
  def change
    create_table :visitors do |t|
      t.string :name
      t.string :relation
      t.string :classification
      t.integer :no_of_visit
      t.datetime :last_visited
      t.text :notes

      t.timestamps
    end
  end
end
