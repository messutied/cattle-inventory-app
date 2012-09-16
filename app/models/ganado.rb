class Ganado < ActiveRecord::Base
  belongs_to :ganado_grupo
  has_many :movimiento_ganados, :dependent => :destroy
  has_many :movimientos, :through => :movimiento_ganados, :uniq => true

  scope :un_mes, lambda {where("id=1 or id=2")}

  def self.recuento_info(predio, gestion)
    #gestion = Gestion.get_gestion

    rec_mes_actual = nil
    rec_mes_anterior = nil

    # Revisar recuentos en el mes
    mov = Movimiento.find( 
      :all, 
      :joins => :ganados, 
      :conditions => ["fecha >= ? and fecha < ? and movimientos_tipo_id=9 and predio_id = ?", 
      gestion.desde, gestion.hasta, predio],
      :order => "fecha desc",
      :limit => 1
      )

    if mov.any?
      rec_mes_actual = mov.first
    end

    # obtener el ultimo recuento anterior a gestion
    mov = Movimiento.find(
      :all, 
      :joins => :ganados, 
      :conditions => ["fecha < ? and movimientos_tipo_id=9 and predio_id = ?", gestion.desde, predio],
      :order => "fecha desc",
      :limit => 1
      )

    if mov.any?
      rec_mes_anterior = mov.first
    end

    return { :mes_actual => rec_mes_actual, 
             :mes_anterior => rec_mes_anterior, 
             :last => rec_mes_actual != nil ? rec_mes_actual : rec_mes_anterior }
  end
 end
