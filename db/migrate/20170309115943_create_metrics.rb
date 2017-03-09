class CreateMetrics < ActiveRecord::Migration[5.0]
  def change
    create_table :metrics do |t|
      t.string :metric_name
      t.string :value
      t.decimal :lat, :precision => 18, :scale => 15
      t.decimal :lon, :precision => 18, :scale => 15
      t.timestamp :timestamp
      t.integer :driver_id
    end
  end
end
