class Driver < ApplicationRecord
  has_many :metrics

  validates :license_number, presence: true
end
