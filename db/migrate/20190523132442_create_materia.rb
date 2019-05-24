class CreateMateria < ActiveRecord::Migration
  def change
    create_table :materia do |t|
      t.string :nome
      t.text :descricao

      t.timestamps
    end
  end
end
