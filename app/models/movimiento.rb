class Movimiento < ActiveRecord::Base
    has_many :movimiento_ganados, :dependent => :destroy

    print "\n\n\n********** Testing"

    accepts_nested_attributes_for :movimiento_ganados, 
        :reject_if => lambda { |m| m[:ganado_id].blank? or m[:cant].blank? }, 
        :allow_destroy => true
    

    validates  :detalle, :movimientos_tipo_id, :presence => true
end
 