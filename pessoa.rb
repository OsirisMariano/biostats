class Pessoa
  attr_reader :nome, :telefone, :endereco, :peso, :altura, :idade, :sexo, :nivel_atividade

  def initialize(dados = {})
    self.peso             = dados[:peso]
    self.altura           = dados[:altura]
    self.idade            = dados[:idade]
    self.sexo             = dados[:sexo]
    self.nivel_atividade  = dados[:nivel_atividade]

    @nome                 = dados[:nome] || "Não informado"
    @telefone             = dados[:telefone]
    @endereco             = dados[:endereco]
  end

  def peso=(valor)
    v = valor.to_f
    raise "Peso fora dos limites humanos (2kg - 500kg)" unless v.between?(2, 500)
    @peso = v
  end

  def altura=(valor)
    v = valor.to_f
    raise "Altura fora dos limites humanos (0.5m - 2.5m)" unless v.between?(0.5, 2.5)
    @altura = v
  end

  def idade=(valor)
    v = valor.to_i
    raise "Idade inválida (0 - 120 anos)" unless v.between?(0, 120)
    @idade = v
  end

  def sexo=(valor)
    v = valor.to_s.upcase
    raise "Sexo deve ser M ou F" unless ["M", "F"].include?(v)
    @sexo = v
  end

  def nivel_atividade=(valor)
    v = valor.to_s
    # Corrigido: Removido o duplo 'unless'
    raise "Nível de atividade inválido" unless ["1", "2", "3"].include?(v)
    @nivel_atividade = v
  end

  def nome=(valor)
    @nome = valor.to_s.strip
  end

  def telefone=(valor)
    @telefone = valor.to_s.strip
  end

  def endereco=(valor)
    @endereco = valor.to_s.strip
  end

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
    if @sexo == "M"
      (66.5 + (13.75 * @peso) + (5.0 * (@altura * 100)) - (6.75 * @idade)).round(2)
    else
      (655.1 + (9.56 * @peso) + (1.85 * (@altura * 100)) - (4.67 * @idade)).round(2)
    end
  end

  def gasto_total
    fatores = { "1" => 1.2, "2" => 1.55, "3" => 1.9 }
    (tmb * fatores[@nivel_atividade]).round(2)
  end

  def agua_diaria
    (@peso * 0.035).round(2)
  end
end # FIM DA CLASSE (Agora no lugar certo)