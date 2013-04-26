class ConfiguracionDescarte < ConfiguracionCambioAnimal
  default_scope where(tipo: "descarte")
  after_create -> { self.tipo = "descarte" }
end