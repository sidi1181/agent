class CreateContrats < ActiveRecord::Migration[7.1]
  def change
    create_table :contrats do |t|
      t.date :date_debut
      t.date :date_fin
      t.string :status
      t.references :agent, null: true, foreign_key: true

      t.timestamps
    end
  end
end
