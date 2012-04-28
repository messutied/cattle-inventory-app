class RenameGanadoGrupoShortName < ActiveRecord::Migration
 def self.up
    rename_column :ganados, :short_name, :nombre_corto
  end

  def self.down
    rename_column :ganados, :nombre_corto, :short_name
  end
end
