class AddGenderFieldToVisitors < ActiveRecord::Migration[7.0]
  def change
    add_column :visitors, :gender, :string
  end
end
