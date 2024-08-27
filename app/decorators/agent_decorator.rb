class AgentDecorator < Draper::Decorator
  delegate_all

  def record_creation_date
    "le #{created_at.strftime('%d/%m/%Y')}"
  end

end
