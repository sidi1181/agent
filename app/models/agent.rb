class Agent < ApplicationRecord
  belongs_to :direction
  has_many :contrats

  include PgSearch::Model

  pg_search_scope :search_by_name, 
    against: :name,
    associated_against: {
      direction: :name
    },
    using: {
      tsearch: { prefix: true } 
    }

  scope :created_on, -> (date){ where(created_at: date.beginning_of_day..date.end_of_day)}

  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :direction, presence: true
end
