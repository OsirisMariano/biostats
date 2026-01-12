module Escritorio
  def self.salvar(conteudo)
    puts "DEBUG: Tentando salvar o arquivo aogra..."

    File.open("relatorio.txt", "a") do |arquivo|
      arquivo.puts "\n" + + "="*40
      arquivo.puts "RELATORIO GERADO EM #{Time.now.strftime('%d/%m/%Y %H:%M')}"
      arquivo.puts conteudo
      arquivo.puts "="*40
    end
  end

  def self.ler_historico
    nome_arquivo = "relatorio.txt"

    if File.exist?(nome_arquivo)
      puts "\n --- HISTÓRIO DE REGISTROS ---"
      puts File.read(nome_arquivo)
      puts "--- FIM DO HISTÓRICO ---"
    else
      puts "\nNenhum histórico encontrado. Salve um relatório primeiro."
    end
  end
end