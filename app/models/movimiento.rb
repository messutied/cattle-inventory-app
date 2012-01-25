class Movimiento < ActiveRecord::Base
    has_many :movimiento_ganados, :dependent => :destroy

    accepts_nested_attributes_for :movimiento_ganados
end
