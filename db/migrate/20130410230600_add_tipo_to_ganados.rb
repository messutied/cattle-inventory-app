class AddTipoToGanados < ActiveRecord::Migration
  def change
    add_column :ganados, :tipo, :string, limit: "10"

  end
end
