class Driver < ApplicationRecord
  has_many :metrics

  # FIXME: Remove next line if business would like to save unindentifyed drivers
  validates :name, :license_number, presence: true
end
