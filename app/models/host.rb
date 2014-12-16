class Host < ActiveRecord::Base
  belongs_to :rack_cabinet
  composed_of :unit_type, class_name: 'HostType', mapping: %w[type type]

  validates :name, :type, presence: true
end
