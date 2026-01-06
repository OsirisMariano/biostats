module Calculadora
  def self.calcular_imc(peso, altura)
    (peso / (altura**2)).round(2)
  end

  def self.classificar_imc(imc)
    case imc
    when 0...18.5
      "\e[33mBaixo peso\e[0m"
    when 18.5...24.9
      "\e[32mPeso normal\e[0m"
    when 25...29.9
      "\e[33mSobrepeso\e[0m"
    else
      "\e[31mObesidade\e[0m"
    end
  end

  def self.calcular_tmb(peso, altura, idade, sexo)
    altura_cm = altura * 100

    base = (10 * peso) + (6.25 * altura_cm) - (5 * idade)

    if sexo == "M"
      base + 5
    else
      base - 161
    end
  end
end