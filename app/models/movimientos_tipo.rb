class MovimientosTipo < ActiveRecord::Base
    has_many :movimientos
    has_many :inventario_predio_ingr_egrs

    scope :movimientos, lambda { where("tipo='i' or tipo='e'") }
end
