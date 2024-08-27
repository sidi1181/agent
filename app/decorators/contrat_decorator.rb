class ContratDecorator < ApplicationDecorator
  delegate_all

  def operation_date
    date_debut = object.date_debut
    date_fin = object.date_fin

    if date_debut && date_fin
      "Du #{date_debut.strftime('%d/%m/%Y')} au #{date_fin.strftime('%d/%m/%Y')}"
    elsif date_debut
      "À partir du #{date_debut.strftime('%d/%m/%Y')}"
    elsif date_fin
      "Jusqu'au #{date_fin.strftime('%d/%m/%Y')}"
    else
      'Dates non spécifiées'
    end
  end

end
