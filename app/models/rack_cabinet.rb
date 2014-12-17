class RackCabinet < ActiveRecord::Base
  composed_of :dc_location, class_name: 'Location', mapping: %w[location name]
  has_many :hosts, foreign_key: 'rack_id'

  validates :name, :location, presence: :true

  scope :without_hosts, -> { includes(:hosts).where(hosts: { id: nil }) }
  scope :with_multi, ->(host_type) { joins(:hosts).group(:type).having("count(type = '#{host_type.type}') > 1") }

  def self.make(name, location)
    create!(name: name, dc_location: location)
  end
end
