class MovimientosTipo < ActiveRecord::Base
    has_many :movimientos

    scope :movimientos, lambda { where("tipo='i' or tipo='e'") }
end
