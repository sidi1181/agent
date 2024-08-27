class Contrat < ApplicationRecord
  belongs_to :agent

  include PgSearch::Model


  pg_search_scope :search_by_status,  
    against: :status, 
    associated_against: {
      agent: :name
    },
    using: { tsearch: { prefix: true } }


  scope :search_by_date_debut, ->(date) {
    where(date_debut: date) if date.present?
  }
end
