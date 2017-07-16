class Client < ActiveRecord::Base
  has_many :trobles, dependent: :destroy
  validates :name, :level, :phone, presence: true
  validates :phone, numericality: true
end
