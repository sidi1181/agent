class ApplicationDecorator < Draper::Decorator
  delegate_all

  def formatted_created_at
    object.created_at.strftime('le <strong>%d/%m/%Y</strong> <br> à %H:%M:%S').html_safe
  end
end
