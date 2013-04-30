# encoding: UTF-8

require "spec_helper"

describe CambioEdad do
  include InventarioHelpers

  let!(:gestion) { Fabricate :gestion}
  let(:san_vicente) { Fabricate :san_vicente }
  let!(:ganado_grupo1) { Fabricate :ganado_grupo }
  let!(:ganado_grupo2) { Fabricate :ganado_grupo }
  let(:ganados1) { ganado_grupo1.ganados }
  let(:ganados2) { ganado_grupo2.ganados }
  let(:inventario_predio) { InventarioPredio.get_inventario(san_vicente.id) }
  let(:compra) { Fabricate :compra }

  context "cuando el usuario realiza el cambio de edad anual" do
    before do
      crear_recuento_cero
      crear_ingreso([5, 0, 8, 2])
      Fabricate(:configuracion, configuracion_cambio_edads: [
        Fabricate(:configuracion_cambio_edad, ganado_desde: ganados1.first, ganado_hasta: ganados1.second),
        Fabricate(:configuracion_cambio_edad, ganado_desde: ganados1.second, ganado_hasta: ganados2.second),
        Fabricate(:configuracion_cambio_edad, ganado_desde: ganados2.first, ganado_hasta: ganados2.second)
      ])
      Fabricate(:cambio_edad)
    end

    let(:ip_cambio_animal) { inventario_predio.inventario_predio_cambio_animals.first }
    let(:ip_c_animal_ganados) { ip_cambio_animal.inventario_predio_cambio_animal_ganados }

    it "existe solo un CambioAnimal" do
      CambioAnimal.count.should == 1
    end

    it "se crea un InventarioPredioCambioAnimal que es un Cambio de Edad" do
      inventario_predio.inventario_predio_cambio_animals.count.should == 1
      inventario_predio.inventario_predio_cambio_animals.first.tipo.should == "c_edad"
    end

    it { ip_c_animal_ganados.count.should == 4 }

    it "se crean InventarioPredioCambioAnimalGanados" do
      ip_c_animal_ganados.find_by_ganado_id(ganados1.first.id).cant_salida.should == 5
      ip_c_animal_ganados.find_by_ganado_id(ganados1.first.id).cant_entrada.should == 0

      ip_c_animal_ganados.find_by_ganado_id(ganados1.second.id).cant_salida.should == 0
      ip_c_animal_ganados.find_by_ganado_id(ganados1.second.id).cant_entrada.should == 5

      ip_c_animal_ganados.find_by_ganado_id(ganados2.first.id).cant_salida.should == 8
      ip_c_animal_ganados.find_by_ganado_id(ganados2.first.id).cant_entrada.should == 0

      ip_c_animal_ganados.find_by_ganado_id(ganados2.second.id).cant_salida.should == 0
      ip_c_animal_ganados.find_by_ganado_id(ganados2.second.id).cant_entrada.should == 8
    end

    it "se actualiza el inventario por predio por ganado" do
      inventario_predio.inventario_predio_ganados.find_by_ganado_id(ganados1.first.id).cant.should == 0
      inventario_predio.inventario_predio_ganados.find_by_ganado_id(ganados1.second.id).cant.should == 5
      inventario_predio.inventario_predio_ganados.find_by_ganado_id(ganados2.first.id).cant.should == 0
      inventario_predio.inventario_predio_ganados.find_by_ganado_id(ganados2.second.id).cant.should == 10
    end

    it "se actualiza el inventario por predio" do
      inventario_predio.cant.should == 15
    end
  end
end