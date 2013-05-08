# encoding: UTF-8

class CurrentGestionValidator < ActiveModel::Validator
  def validate(record)
    unless record.gestion.esta_abierta?
      record.errors[:gestion__cerrada] = "La gestion del registro está cerrada"
    end
  end
end