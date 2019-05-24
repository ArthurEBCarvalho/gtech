class CreateProvas < ActiveRecord::Migration
  def change
    create_table :provas do |t|
      t.decimal :nota, :precision => 4, :scale => 2
      t.date :data
      t.references :aluno, index: true, foreign_key: true
      t.references :materium, index: true, foreign_key: true

      t.timestamps
    end
  end
end
