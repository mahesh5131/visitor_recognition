class AddImageStringFieldToVisitors < ActiveRecord::Migration[7.0]
  def change
    add_column :visitors, :image_string, :text
  end
end
