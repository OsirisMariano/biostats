module Escritorio
  def self.salvar(conteudo)
    File.open("relatorio.txt", "a") do |arquivo|
      arquivo.puts "\n" + + "="*40
      arquivo.puts "RELATORIO GERADO EM #{Time.now.strftime('%d/%m/%Y %H:%M')}"
      arquivo.puts conteudo
      arquivo.puts "="*40
    end
  end

  def self.salvar_csv(dados)
      nome_arquivo = "dados_clientes.csv"

      unless File.exist?(nome_arquivo)
        File.open(nome_arquivo, "w") do |arquivo|
          arquivo.puts "Data;Nome;Telefone;IMC;Classificacao;TMB;Gasto_Real;Agua_litros"
        end
      end

      File.open(nome_arquivo, "a") do |arquivo|
        arquivo.puts  "#{Time.now.strftime('%d/%m/%Y %H:%M')};" + 
                      "#{dados[:nome]};" +
                      "#{dados[:telefone]};" +
                      "#{dados[:imc]};" + 
                      "#{dados[:classificacao]};" + 
                      "#{dados[:tmb]};" + 
                      "#{dados[:gasto_real]};" +
                      "#{dados[:agua]}"
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

  def self.buscar_por_nome(nome_busca)
    nome_arquivo = "relatorio.txt"
    
    unless File.exist?(nome_arquivo)
      puts "Arquivo de histórico não encontrado."
      return
    end

    conteudo = File.read(nome_arquivo)
    
    fichas = conteudo.split("========================================").map(&:strip).reject(&:empty?)
    
    resultados = fichas.select { |ficha| ficha.downcase.include?(nome_busca.downcase) }

    if resultados.any?
      puts "\n🔍 Encontramos #{resultados.size} registro(s) para '#{nome_busca}':"
      resultados.each do |resultado|
        puts "\n" + "="*40
        puts resultado
        puts "="*40
      end
    else
      puts "\nNenhum registro encontrado para: '#{nome_busca}'"
    end
  end

  def self.eliminar_por_nome(nome_busca)
    arquivos = ["relatorio.txt", "dados_clientes.csv"]
    encontrado = false

    arquivos.each do |nome_arquivo|
      next unless File.exist?(nome_arquivo)
      if nome_arquivo.end_with?(".txt")
        conteudo = File.read(nome_arquivo)
        fichas = conteudo.split("========================================").map(&:strip).reject(&:empty?)

        novas_fichas = fichas.reject { |ficha| ficha.downcase.include?(nome_busca.downcase) }
        
        if fichas.size != novas_fichas.size
          encontrado = true
          File.open(nome_arquivo, "w") do |f|
            novas_fichas.each do |ficha|
              f.puts "========================================"
              f.puts ficha
              f.puts "========================================"
            end
          end
        end

      elsif nome_arquivo.end_with?(".csv")
        linhas = File.readlines(nome_arquivo)
        cabecalho = linhas.shift

        novas_linhas = linhas.reject { |linha| linha.downcase.include?(nome_busca.downcase)}

        File.open(nome_arquivo, "w") do |f|
          f.puts cabecalho
          f.print novas_linhas.join
        end
      end
    end
    encontrado
  end
end