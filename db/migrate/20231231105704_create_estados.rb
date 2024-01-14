class CreateEstados < ActiveRecord::Migration[7.1]
  def change
    create_table :estados do |t|
      t.string :nome
      t.text :sigla

      t.timestamps
    end
  end
end
