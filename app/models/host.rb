class Host < ActiveRecord::Base
  def self.inheritance_column; nil end

  belongs_to :rack, class_name: 'RackCabinet', foreign_key: 'rack_id'
  composed_of :host_type, class_name: 'HostType', mapping: %w[type type]

  validates :name, :type, presence: true

  scope :in_same_rack, -> (host_id) { where(rack_id: Host.select(:rack_id).where(id: host_id)) }
  scope :in_location, -> (location) { joins(:rack).where(rack_cabinets: { location: location }) }
  scope :with_type, -> (type) { where(type: type) }

  def self.make(name, type)
    create!(name: name, host_type: type)
  end
end
