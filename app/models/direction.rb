class Direction < ApplicationRecord
  has_many :agents

  validates :name, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name,
  against: :name,
  using: {
    tsearch: {prefix: true}
  }


end