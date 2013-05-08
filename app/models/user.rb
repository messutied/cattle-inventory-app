class User < ActiveRecord::Base
  belongs_to :user_type

  def is_admin?
    user_type.nombre == "ADM"
  end

  def is_owner?
    user_type.nombre == "Owner"
  end

  def is_encargado?
    user_type.nombre == "Encargado Ganaderia"
  end
end
