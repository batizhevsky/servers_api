class RackCabinet < ActiveRecord::Base
  composed_of :dc_location, class_name: 'Location', mapping: %w[location name]
  has_many :hosts

  validates :name, :location, presence: :true
end
