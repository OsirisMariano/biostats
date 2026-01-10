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
end