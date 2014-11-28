class CreateOrganizadors < ActiveRecord::Migration
  def change
    create_table :organizadors do |t|
      t.string :nombre_org
      t.string :apellido_pat_org
      t.string :apellido_mat_org
      t.decimal :rut_org
      t.boolean :sexo_org
      t.date :fecha_nac_org
      t.string :email_org
      t.string :foto_org

      t.timestamps
    end
  end
end
