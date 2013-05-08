class Predio < ActiveRecord::Base
	has_many :movimientos, dependent: :destroy
	has_many :movimientos, :foreign_key => :predio_sec_id
end
