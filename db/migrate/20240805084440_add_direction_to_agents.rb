class AddDirectionToAgents < ActiveRecord::Migration[7.1]
  def change
    add_reference :agents, :direction, null: false, foreign_key: true
  end
end
