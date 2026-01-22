module Leitor
  # Captura números com tratamento de erro
  def self.ler_numero(mensagem)
    loop do
      print "#{mensagem}: "
      entrada = gets.chomp.gsub(',', '.')
      if entrada.match?(/^\d+(\.\d+)?$/)
        numero = entrada.to_f

        if numero > 0
          return numero
        else
          puts "Erro: O valor deve ser maior que zero."
        end
      else
        puts "Erro: Entrada inválida. Por favor, digite apenas números."
      end  
    end
  end

  # Captura texto com validação de opções
  def self.ler_texto(mensagem, opcoes_validas = nil)
    loop do
      print "#{mensagem} #{opcoes_validas}: "
      entrada = gets.chomp.upcase.strip

      if opcoes_validas.nil?
        return entrada unless entrada.empty?
        puts "Erro: Este campo não pode ficar vazio."
      elsif opcoes_validas.include?(entrada)
        return entrada
      else
        puts "Erro: Opção inválida. Escolha entre #{opcoes_validas}."
      end
    end
  end

  def self.coletar_dados_pessoais
    puts "--- CADASTRO DE DADOS ---"
    nome = ler_texto("Nome completo")
    telefone = ler_texto("telefone")
    endereco = ler_texto("Endereço")

    { nome: nome, telefone: telefone, endereco: endereco}  
  end
end

