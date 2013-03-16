class SetDefaultsToInventoryTables < ActiveRecord::Migration
  def up
    change_column :inventario_ganados, :cant, :integer, default: 0

    change_column :inventario_predio_ganados, :cant, :integer, default: 0
    change_column :inventario_predio_ganados, :saldo_parcial, :integer, default: 0

    change_column :inventario_predio_ingr_egr_ganados, :cant, :integer, default: 0
    change_column :inventario_predio_mov_ganados, :cant, :integer, default: 0

    change_column :inventario_predio_ingr_egrs, :cant, :integer, default: 0
    change_column :inventario_predio_ingr_egrs, :cant_may_a, :integer, default: 0
    change_column :inventario_predio_ingr_egrs, :cant_men_a, :integer, default: 0

    change_column :inventario_predio_movs, :cant, :integer, default: 0
    change_column :inventario_predio_movs, :cant_may_a, :integer, default: 0
    change_column :inventario_predio_movs, :cant_men_a, :integer, default: 0

    change_column :inventario_predios, :cant, :integer, default: 0
    change_column :inventario_predios, :cant_may_a, :integer, default: 0
    change_column :inventario_predios, :cant_men_a, :integer, default: 0

    change_column :inventarios, :cant, :integer, default: 0
    change_column :inventarios, :cant_may_a, :integer, default: 0
    change_column :inventarios, :cant_men_a, :integer, default: 0
  end

  def down

    change_column :inventario_ganados, :cant, :integer, default: nil

    change_column :inventario_predio_ganados, :cant, :integer, default: nil
    change_column :inventario_predio_ganados, :saldo_parcial, :integer, default: nil
    
    change_column :inventario_predio_ingr_egr_ganados, :cant, :integer, default: nil
    change_column :inventario_predio_mov_ganados, :cant, :integer, default: nil

    change_column :inventario_predio_ingr_egrs, :cant, :integer, default: nil
    change_column :inventario_predio_ingr_egrs, :cant_may_a, :integer, default: nil
    change_column :inventario_predio_ingr_egrs, :cant_men_a, :integer, default: nil

    change_column :inventario_predio_movs, :cant, :integer, default: nil
    change_column :inventario_predio_movs, :cant_may_a, :integer, default: nil
    change_column :inventario_predio_movs, :cant_men_a, :integer, default: nil

    change_column :inventario_predios, :cant, :integer, default: nil
    change_column :inventario_predios, :cant_may_a, :integer, default: nil
    change_column :inventario_predios, :cant_men_a, :integer, default: nil

    change_column :inventarios, :cant, :integer, default: nil
    change_column :inventarios, :cant_may_a, :integer, default: nil
    change_column :inventarios, :cant_men_a, :integer, default: nil
  end
end
