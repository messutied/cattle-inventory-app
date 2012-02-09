class MovimientoGanado < ActiveRecord::Base
    belongs_to :movimiento

    validates :ganado_id, :cant, :presence => true
end
