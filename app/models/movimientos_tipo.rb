class MovimientosTipo < ActiveRecord::Base
    scope :movimientos, lambda { where("tipo='i' or tipo='e'") }
end
