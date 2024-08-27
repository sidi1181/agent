class AddBirthdayAndStatusToAgents < ActiveRecord::Migration[7.1]
  def change
    add_column :agents, :birthday, :string
    add_column :agents, :status, :string
  end
end
