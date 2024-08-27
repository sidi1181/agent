# app/services/agent_import_service.rb
require 'roo'

class AgentImportService
  def initialize(file)
    @file = file
  end

  def call
    import_data
  end

  private

  def import_data
    # Ouvrir le fichier Excel avec roo
    xlsx = Roo::Excelx.new(@file.path)

    # Prendre la première feuille du fichier
    worksheet = xlsx.sheet(0)

    # Lire les lignes du fichier Excel
    worksheet.each_with_index do |row, index|
      next if index == 0  # Ignorer la première ligne (en-têtes)

      # Extraire les valeurs de chaque cellule
      id, name, email, code, direction_name, status = row

      # Trouver ou créer la direction
      direction = Direction.find_or_create_by(name: direction_name)

      # Créer ou mettre à jour l'agent
      Agent.find_or_create_by(id: id) do |agent|
        agent.name = name
        agent.email = email
        agent.code = code
        agent.direction = direction
        agent.status = status
      end
    end
  end
end
