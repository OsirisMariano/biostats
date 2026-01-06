module Calculadora
  # 1. Índice de Massa Corporal
  def self.calcular_imc(peso, altura)
    (peso / (altura**2)).round(2)
  end

  def self.classificar_imc(imc)
    case imc
    when 0...18.5     then "\e[33mBaixo peso\e[0m"
    when 18.5...24.9  then "\e[32mPeso normal\e[0m"
    when 25...29.9    then "\e[33mSobrepeso\e[0m"
    else                   "\e[31mObesidade\e[0m"
    end
  end

  # 2. Taxa Metabólica Basal
  def self.calcular_tmb(peso, altura, idade, sexo)
    altura_cm = altura * 100
    base = (10 * peso) + (6.25 * altura_cm) - (5 * idade)
    sexo == "M" ? (base + 5) : (base - 161)
  end

  # 3. Gasto Energético Total
  def self.calcular_gasto_total(tmb, nivel)
    fatores = { "1" => 1.2, "2" => 1.55, "3" => 1.9 }
  #  multiplicador = fatores[nivel] || 1.0
    (tmb * fatores[nivel]).round(2)
  end

    # 4. Hidratação Diária
    def self.calcular_hidratacao(peso)
      litros =  (peso * 0.035).round(2)
      copos =   (litros / 0.25).ceil
      { litros: litros, copos: copos }
    end
end



