class Metric < ApplicationRecord
  belongs_to :driver
  self.per_page = 50

  validates :driver_id, presence: true
end
