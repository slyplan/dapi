class RemoveTimestampColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :metrics, :timestamp
  end
end
