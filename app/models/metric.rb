class Metric < ApplicationRecord
  belongs_to :driver
  self.per_page = 50

  # FIXME: Remove next line if business would like to save garbage metrics
  validates :metric_name, :value, presence: true
end
