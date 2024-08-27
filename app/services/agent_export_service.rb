# app/services/agent_export_service.rb
require 'fast_excel'

class AgentExportService
  def initialize(agents, file_name = 'agents.xlsx')
    @agents = agents
    @file_name = file_name
  end

  def call
    generate_excel
  end

  private

  def generate_excel
    workbook = FastExcel.open(constant_memory: true)
    worksheet = workbook.add_worksheet

    headers = ["ID", "Name", "E-mail", "Registration Number", "Direction", "Status"]
    worksheet.append_row(headers)

    @agents.each do |agent|
      row = [
        agent.id,
        agent.name,
        agent.email,
        agent.code,
        agent.direction.present? ? agent.direction.name : 'No Direction',
        agent.status
      ]
      worksheet.append_row(row)
    end

    # Fermer le workbook et récupérer le contenu du fichier sous forme de chaîne
    workbook_data = workbook.read_string

    # Sauvegarder le fichier Excel dans le dossier public en mode binaire
    file_path = Rails.root.join('public', @file_name)
    File.open(file_path, 'wb') { |file| file.write(workbook_data) }  # Écrire en mode binaire
  end
end
