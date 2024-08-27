def export_agents(agents)
  AgentExportService.new(agents).call
  send_file Rails.root.join('public', 'agents.xlsx'), type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', disposition: 'attachment'
end
