class Client < ActiveRecord::Base
  has_many :trobles, dependent: :destroy
  validates :name, :level, :phone, presence: true
  validates :name, length: { maximum: 30 }
  validates :level, length: { maximum: 30 }
  # validates_format_of :phone, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates :phone, numericality: :only_integer
  validates :phone, length: { maximum: 12 }
  validates :phone, length: { minimum: 10 }
  validates :phone, uniqueness: true
end
