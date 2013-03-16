require "spec_helper"

describe "Calculo del inventario" do
  let!(:gestion) { Fabricate :gestion,  estado: 'C'}
  let!(:gestion_anterior) { Fabricate :anterior, estado: 'A' }
  let(:san_vicente) { Fabricate :san_vicente }
  let(:compra) { Fabricate :compra }
  let(:venta) { Fabricate :venta }
  let(:ganado_grupo) { Fabricate :ganado_grupo }
  let(:ganados) { ganado_grupo.ganados }
  let(:inventario_predio) { InventarioPredio.get_inventario(san_vicente.id) }

  context "Cuando el usuario registra ingresos/egresos de ganado" do
    before do
      Fabricate(:ingreso, predio: san_vicente, movimientos_tipo: compra,
        fecha: Time.now.advance(months: -1), movimiento_ganados: [
        Fabricate(:movimiento_ganado, cant: 10, ganado: ganados.first),
        Fabricate(:movimiento_ganado, cant: 40, ganado: ganados.second)
      ])

      Fabricate(:ingreso, predio: san_vicente, movimientos_tipo: compra, 
        fecha: Time.now.advance(months: -1), movimiento_ganados: [
        Fabricate(:movimiento_ganado, cant: 50, ganado: ganados.first)
      ])

      Fabricate(:egreso, predio: san_vicente, movimientos_tipo: venta, 
        fecha: Time.now.advance(months: -1), movimiento_ganados: [
        Fabricate(:movimiento_ganado, cant: 30, ganado: ganados.first)
      ])
      # ActiveRecord::Base.logger = Logger.new(STDOUT) if defined?(ActiveRecord::Base)
    end

    let(:inventario_ingr_egr_comprados) { inventario_predio.inventario_predio_ingr_egrs.find_by_movimientos_tipo_id(compra.id) }
    let(:inventario_ingr_egr_vendidos) { inventario_predio.inventario_predio_ingr_egrs.find_by_movimientos_tipo_id(venta.id) }

    it "deberia guardarse en el inventario por predio ingr/egr por ganado" do
      inventario_ingr_egr_comprados.inventario_predio_ingr_egr_ganados
        .find_by_ganado_id(ganados.first.id).cant.should == 60

      inventario_ingr_egr_comprados.inventario_predio_ingr_egr_ganados
        .find_by_ganado_id(ganados.second.id).cant.should == 40
      
      inventario_ingr_egr_vendidos.inventario_predio_ingr_egr_ganados
        .find_by_ganado_id(ganados.first.id).cant.should == 30
    end

    it "deberia guardarse en el inventario por predio ingr/egr" do
      inventario_ingr_egr_comprados.cant.should == 100
      inventario_ingr_egr_vendidos.cant.should == 30
    end

    it "deberia guardarse inventario_predio_ganado 1 por cada ganado" do
      inventario_predio.inventario_predio_ganados.find_all_by_ganado_id(ganados.first.id).count.should == 1
      inventario_predio.inventario_predio_ganados.find_all_by_ganado_id(ganados.second.id).count.should == 1
    end

    it "deberia guardarse en el inventario por predio por ganado" do
      inventario_predio.inventario_predio_ganados.find_by_ganado_id(ganados.first.id).cant.should == 30
      inventario_predio.inventario_predio_ganados.find_by_ganado_id(ganados.second.id).cant.should == 40
    end

    it "deberia guardarse en el inventario por predio" do
      inventario_predio.cant.should == 70
    end

    it "deberia guardarse en el inventario" do
      inventario_predio.inventario.cant.should == 70
    end

    context "cuando el usuario cierra una gestion, abre una nueva y crea mas ingresos/egresos" do
      before do
        gestion_anterior.update_attributes(estado: 'C')
        gestion.update_attributes(estado: 'A')

        Fabricate(:ingreso, predio: san_vicente, movimientos_tipo: compra,
          fecha: Time.now, movimiento_ganados: [
          Fabricate(:movimiento_ganado, cant: 90, ganado: ganados.first),
          Fabricate(:movimiento_ganado, cant: 200, ganado: ganados.second)
        ])
      end

      let(:inventario_predio) { InventarioPredio.get_inventario(san_vicente.id) }
      let(:inventario_ingr_egr_comprados) { inventario_predio.inventario_predio_ingr_egrs.find_by_movimientos_tipo_id(compra.id) }
      let(:inventario_ingr_egr_vendidos) { inventario_predio.inventario_predio_ingr_egrs.find_by_movimientos_tipo_id(venta.id) }

      it "deberia guardarse en el inventario por predio ingr/egr por ganado de la nueva gestion" do
        inventario_ingr_egr_comprados.inventario_predio_ingr_egr_ganados
          .find_by_ganado_id(ganados.first.id).cant.should == 90

        inventario_ingr_egr_comprados.inventario_predio_ingr_egr_ganados
          .find_by_ganado_id(ganados.second.id).cant.should == 200
      end

      it "deberia guardarse en el inventario por predio ingr/egr" do
        inventario_ingr_egr_comprados.cant.should == 290
      end

      it "deberia guardarse en el inventario por predio por ganado" do
        inventario_predio.inventario_predio_ganados.find_by_ganado_id(ganados.first.id).cant.should == 120
        inventario_predio.inventario_predio_ganados.find_by_ganado_id(ganados.second.id).cant.should == 240
      end

      it "deberia guardarse en el inventario por predio, sumandose con el saldo de la gestion anterior" do
        inventario_predio.cant.should == 240 + 120
      end

      it "deberia guardarse en el inventario, sumandose con el saldo de la gestion anterior" do
        inventario_predio.inventario.cant.should == 240 + 120
      end
    end
  end
end