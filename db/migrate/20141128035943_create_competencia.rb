class CreateCompetencia < ActiveRecord::Migration
  def change
    create_table :competencia do |t|
      t.string :nombre_comp
      t.text :descripcion_comp
      t.string :tipo_comp
      t.boolean :ida_vuelta_comp
      t.integer :cant_part_comp
      t.date :fecha_inicio_comp
      t.date :fecha_termino_comp
      t.integer :cant_grupos_comp
      t.integer :cant_fases_comp
      t.integer :cant_arbitros_comp
      t.integer :cant_jug_tit
      t.integer :cant_jug_ban
      t.integer :cant_max_jug_comp
      t.integer :cant_mod_comp
      t.boolean :privacidad_comp

      t.timestamps
    end
  end
end
