class CreateAgents < ActiveRecord::Migration[7.1]
  def change
    create_table :agents do |t|
      t.string :name
      t.string :email
      t.string :code
      t.string :comment

      t.timestamps
    end
  end
end
