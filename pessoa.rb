class Pessoa
  attr_accessor :nome, :telefone, :endereco, :peso, :altura, :idade, :sexo, :nivel_atividade

  def initialize(dados = {})
    @nome            = dados[:nome]
    @telefone        = dados[:telefone]
    @endereco        = dados[:endereco]
    @peso            = dados[:peso]
    @altura          = dados[:altura]
    @idade           = dados[:idade]
    @sexo            = dados[:sexo]
    @nivel_atividade = dados[:nivel_atividade]
  end

  # --- MÉTODOS DE CÁLCULO ---

  def imc
    (@peso / (@altura * @altura)).round(2)
  end

  def classificacao_imc
    valor = imc
    return "Abaixo do peso" if valor < 18.5
    return "Peso normal"    if valor < 24.9
    return "Sobrepeso"      if valor < 29.9
    "Obesidade"
  end

  def tmb
    # Fórmula de Harris-Benedict
    if @sexo.upcase == "M"
      (66.5 + (13.75 * @peso) + (5.0 * (@altura * 100)) - (6.75 * @idade)).round(2)
    else
      (655.1 + (9.56 * @peso) + (1.85 * (@altura * 100)) - (4.67 * @idade)).round(2)
    end
  end

  def gasto_total
    # Fatores: 1.2 (Sedentário), 1.55 (Moderado), 1.9 (Atleta)
    fatores = { "1" => 1.2, "2" => 1.55, "3" => 1.9 }
    fator = fatores[@nivel_atividade] || 1.2
    (tmb * fator).round(2)
  end

  def agua_diaria
    (@peso * 0.035).round(2)
  end

  def copos_agua
    (agua_diaria / 0.25).ceil
  end
end