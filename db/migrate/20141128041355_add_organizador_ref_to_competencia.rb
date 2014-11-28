class AddOrganizadorRefToCompetencia < ActiveRecord::Migration
  def change
    add_reference :competencia, :organizador, index: true
  end
end
