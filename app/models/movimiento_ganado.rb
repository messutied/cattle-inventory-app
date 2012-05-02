class MovimientoGanado < ActiveRecord::Base
    belongs_to :movimiento

    validates :ganado_id, :cant, :presence => {:message => "es un campo obligatorio"}
    validates :cant, :numericality => {:only_integer => true, :message => " debe ser número entero"}, :allow_nil => false
    validates :cant_sec, :numericality => {:only_integer => true, :message => " debe ser número entero"}, :allow_nil => true
end
