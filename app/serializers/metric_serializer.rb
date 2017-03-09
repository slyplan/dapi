class MetricSerializer < ActiveModel::Serializer
  attributes :id, :metric_name, :value, :lat, :lon, :timestamp, :driver_id
end
