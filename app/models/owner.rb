class Owner < ActiveRecord::Base
  validates :name, presence: true
  validates :pass_id, presence: true, uniqueness: true
  has_many :visits
end
