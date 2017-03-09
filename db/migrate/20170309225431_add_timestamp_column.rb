class AddTimestampColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :metrics, :timestamp, :integer
  end
end
