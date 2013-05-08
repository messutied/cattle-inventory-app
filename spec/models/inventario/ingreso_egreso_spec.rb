# encoding: UTF-8

require "spec_helper"

describe "IngresoEgreso" do
  include InventarioHelpers

  let!(:gestion) { Fabricate :gestion}
  let(:san_vicente) { Fabricate :san_vicente }
  let!(:ganado_grupo) { Fabricate :ganado_grupo }
  let(:ganados) { ganado_grupo.ganados }
  let(:inventario_predio) { InventarioPredio.get_inventario(san_vicente.id) }
  let(:inventario) { inventario_predio.inventario }
  let(:compra) { Fabricate :compra }
  let(:venta) { Fabricate :venta }

  context "cuando el usuario realiza ingreso de ganado" do
    before do
      @ingreso = crear_ingreso([5, 3])
      @egreso = crear_egreso([4, 0])
    end

    let(:ip_ingr_egr_comprados) { inventario_predio.inventario_predio_ingr_egrs.find_by_movimientos_tipo_id(compra.id) }
    let(:ip_ingr_egr_vendidos) { inventario_predio.inventario_predio_ingr_egrs.find_by_movimientos_tipo_id(venta.id) }
    let(:ip_ganados) { inventario_predio.inventario_predio_ganados }

    it "deberia guardarse en el inventario por predio ingr/egr por ganado" do
      ip_ingr_egr_comprados.inventario_predio_ingr_egr_ganados
        .find_by_ganado_id(ganados.first.id).cant.should == 5

      ip_ingr_egr_comprados.inventario_predio_ingr_egr_ganados
        .find_by_ganado_id(ganados.second.id).cant.should == 3
      
      ip_ingr_egr_vendidos.inventario_predio_ingr_egr_ganados
        .find_by_ganado_id(ganados.first.id).cant.should == 4
      
      ip_ingr_egr_vendidos.inventario_predio_ingr_egr_ganados
        .find_by_ganado_id(ganados.second.id).cant.should == 0
    end

    it "deberia guardarse en el inventario por predio ingr/egr" do
      ip_ingr_egr_comprados.cant.should == 8
      ip_ingr_egr_comprados.cant_men_a.should == 5
      ip_ingr_egr_comprados.cant_may_a.should == 3

      ip_ingr_egr_vendidos.cant.should == 4
      ip_ingr_egr_vendidos.cant_men_a.should == 4
      ip_ingr_egr_vendidos.cant_may_a.should == 0
    end

    it "deberia guardarse 1 inventario_predio_ganado por cada ganado" do
      ip_ganados.find_all_by_ganado_id(ganados.first.id).count.should == 1
      ip_ganados.find_all_by_ganado_id(ganados.second.id).count.should == 1
    end

    it "deberia guardarse en el inventario por predio por ganado" do
      ip_ganados.find_by_ganado_id(ganados.first.id).saldo_inicial.should == 0
      ip_ganados.find_by_ganado_id(ganados.second.id).saldo_inicial.should == 0

      ip_ganados.find_by_ganado_id(ganados.first.id).saldo_parcial.should == 5
      ip_ganados.find_by_ganado_id(ganados.second.id).saldo_parcial.should == 3

      ip_ganados.find_by_ganado_id(ganados.first.id).cant.should == 1
      ip_ganados.find_by_ganado_id(ganados.second.id).cant.should == 3
    end

    it "deberia habe 1 inventario_predio" do
      InventarioPredio.count.should == 1
    end

    it "deberia guardarse en el inventario por predio" do
      inventario_predio.cant.should == 4
    end

    it "deberia habe 1 inventario" do
      Inventario.count.should == 1
    end

    it "deberia guardarse en el inventario" do
      inventario.cant.should == 4
    end

    it "deberia guardarse en el inventario por ganado" do
      inventario.inventario_ganados.find_by_ganado_id(ganados.first.id).cant.should == 1
      inventario.inventario_ganados.find_by_ganado_id(ganados.second.id).cant.should == 3
    end

    context "cuando el usuario edita un ingreso" do
      before do
        mov_ganado = @ingreso.movimiento_ganados.select { |g| g.ganado_id == ganados.first.id }.first
        mov_ganado.cant = 6
        @ingreso.save
      end

      let(:ip_ingr_egr_comprados) { inventario_predio.inventario_predio_ingr_egrs.find_by_movimientos_tipo_id(compra.id) }
      let(:ip_ingr_egr_vendidos) { inventario_predio.inventario_predio_ingr_egrs.find_by_movimientos_tipo_id(venta.id) }
      let(:ip_ganados) { inventario_predio.inventario_predio_ganados }

      it "deberia guardarse en el inventario por predio ingr/egr por ganado" do
        ip_ingr_egr_comprados.inventario_predio_ingr_egr_ganados
          .find_by_ganado_id(ganados.first.id).cant.should == 6

        ip_ingr_egr_comprados.inventario_predio_ingr_egr_ganados
          .find_by_ganado_id(ganados.second.id).cant.should == 3
        
        ip_ingr_egr_vendidos.inventario_predio_ingr_egr_ganados
          .find_by_ganado_id(ganados.first.id).cant.should == 4
        
        ip_ingr_egr_vendidos.inventario_predio_ingr_egr_ganados
          .find_by_ganado_id(ganados.second.id).cant.should == 0
      end
    end
  end
end