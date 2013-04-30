# encoding: UTF-8

require "spec_helper"

describe Descarte do
  include InventarioHelpers

  let!(:gestion) { Fabricate :gestion}
  let(:san_vicente) { Fabricate :san_vicente }
  let!(:ganado_grupo) { Fabricate :ganado_grupo }
  let(:ganados) { ganado_grupo.ganados }
  let(:inventario_predio) { InventarioPredio.get_inventario(san_vicente.id) }
  let(:compra) { Fabricate :compra }

  context "cuando el usuario realiza descarte de ganado" do
    before do
      crear_recuento_cero
      crear_ingreso([5, 0])
      Fabricate(:descarte, predio: san_vicente, cambio_animal_ganados: [
        Fabricate(:cambio_animal_ganado, ganado: ganados.first, ganado_sec: ganados.second, cant: 5)
      ])
    end

    it "existe solo un CambioAnimal" do
      CambioAnimal.count.should == 1
    end

    it "se crea un InventarioPredioCambioAnimal" do
      inventario_predio.inventario_predio_cambio_animals.count.should == 1
    end

    it "se crea o actualiza InventarioPredioCambioAnimal" do
      ip_cambio_animal_ganados = inventario_predio.inventario_predio_cambio_animals[0].inventario_predio_cambio_animal_ganados
      
      ip_cambio_animal_ganados.find_by_ganado_id(ganados.first.id).cant_salida.should == 5
      ip_cambio_animal_ganados.find_by_ganado_id(ganados.first.id).cant_entrada.should == 0

      ip_cambio_animal_ganados.find_by_ganado_id(ganados.second.id).cant_salida.should == 0
      ip_cambio_animal_ganados.find_by_ganado_id(ganados.second.id).cant_entrada.should == 5
    end

    it "se actualiza el inventario por predio por ganado" do
      inventario_predio.inventario_predio_ganados.find_by_ganado_id(ganados.first.id).cant.should == 0
      inventario_predio.inventario_predio_ganados.find_by_ganado_id(ganados.second.id).cant.should == 5
    end

    it "se actualiza el inventario por predio" do
      inventario_predio.cant.should == 5
    end
  end
end