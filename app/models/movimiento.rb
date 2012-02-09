class Movimiento < ActiveRecord::Base
    has_many :movimiento_ganados, :dependent => :destroy

    accepts_nested_attributes_for :movimiento_ganados, 
        # :reject_if => lambda { |m| m[:movimiento_id].blank? }, 
        :allow_destroy => true
    

    validates  :detalle, :movimientos_tipo_id, :presence => true
end
