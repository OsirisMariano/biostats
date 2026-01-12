module Leitor
  # Captura números com tratamento de erro
  def self.ler_numero(mensagem)
    loop do
      print "#{mensagem}: "
      entrada = gets.chomp.gsub(',', '.')

      begin
        return Float(entrada)
      rescue ArgumentError
        puts "\e[31m[Erro]\e[0m Digite um número válido (ex: 75.5)."
      end    
    end
  end

  # Captura texto com validação de opções
  def self.ler_texto(mensagem, opcoes_validas = nil)
    loop do
      print "#{mensagem}: "
      entrada = gets.chomp.strip.upcase

      # Se for válido (ou se não houver restrição), retornamos a entrada
      if opcoes_validas.nil? || opcoes_validas.include?(entrada)
        return entrada
      else
        # Se não for válido, avisamos o usuário e o 'loop' faz perguntar de novo
        puts "\e[31m[Erro]\e[0m Opção inválida. Escolha entre: #{opcoes_validas.join(', ')}"
      end
    end
  end

  def self.coletar_dados_pessoais
    puts "\n --- CADASTRO DE CLIENTE --- "
    print "Nome completo: "
    nome = gets.chomp
    print "Telefone: "
    telefone = gets.chomp
    print "Endereço: "
    endereco = gets.chomp

    {nome: nome, telefone: telefone, endereco: endereco}
  end
end

