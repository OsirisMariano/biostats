require 'tty-table'

module Escritorio
  ARQUIVO_TXT = "relatorio.txt"
  ARQUIVO_CSV = "dados_clientes.csv"
  DIVISOR     = "=" * 40

  # --- MÉTODOS PÚBLICOS (O main.rb enxerga) ---

  def self.salvar_completo(cliente)
    classificacao_limpa = cliente.classificacao_imc.gsub(/\e\[\d+m/, "").gsub(/\e\[0m/, "")
    salvar_txt(cliente, classificacao_limpa)
    salvar_csv(cliente, classificacao_limpa)
    true
  rescue StandardError => e
    puts "Erro ao salvar: #{e.message}"
    false
  end

  def self.ler_historico
    return puts "\nNenhum histórico encontrado." unless File.exist?(ARQUIVO_CSV)

    todas_as_linhas = File.readlines(ARQUIVO_CSV).drop(1)
    dados_filtrados = todas_as_linhas.map do |linha|
    col = linha.chomp.split(";")
    [col[0], col[1], col[3], col[4]] 
  end

    cabecalho_visual = ["DATA", "NOME", "IMC", "STATUS"]
    tabela = TTY::Table.new(header: cabecalho_visual, rows: dados_filtrados)

    tabela_renderizada = tabela.render(:unicode, padding: [0, 1], alignments: [:left, :left, :center, :left])
    largura_tabela = tabela_renderizada.lines.first.chomp.size

    puts "\n" + "=" * largura_tabela
    puts "               HISTÓRICO DE CLIENTES               ".center(largura_tabela)
    puts "=" * largura_tabela
    puts tabela_renderizada

  end

  def self.buscar_por_nome(nome_busca)
    return puts "Arquivo não encontrado." unless File.exist?(ARQUIVO_TXT)

    fichas = File.read(ARQUIVO_TXT).split(DIVISOR).map(&:strip).reject(&:empty?)
    resultados = fichas.select { |f| f.downcase.include?(nome_busca.downcase) }

    if resultados.any?
      puts "\n🔍 Encontramos #{resultados.size} registro(s) para '#{nome_busca}':"
      resultados.each { |r| puts "\n#{DIVISOR}\n#{r}\n#{DIVISOR}" }
    else
      puts "\nNenhum registro encontrado para: '#{termo}'"
    end
  end

  def self.eliminar_por_nome(nome_busca)
    txt_ok = eliminar_do_txt(nome_busca)
    csv_ok = eliminar_do_csv(nome_busca)
    txt_ok || csv_ok
  end

  # --- MÉTODOS PRIVADOS (Lógica interna, o main.rb não vê) ---
  private

  def self.data_formatada
    Time.now.strftime('%d/%m/%Y %H:%M')
  end

  def self.salvar_txt(cliente, classificacao)
    File.open(ARQUIVO_TXT, "a") do |f|
      f.puts "\n#{DIVISOR}"
      f.puts "RELATORIO GERADO EM #{data_formatada}"
      f.puts "Nome:     #{cliente.nome}"
      f.puts "Tel:      #{cliente.telefone}"
      f.puts "End:      #{cliente.endereco}"
      f.puts "----------------------------------------"
      f.puts "IMC:      #{cliente.imc} (#{classificacao})"
      f.puts "TMB:      #{cliente.tmb} kcal/dia"
      f.puts "Gasto:    #{cliente.gasto_total} kcal/dia"
      f.puts "Água:     #{cliente.agua_diaria} L"
      f.puts DIVISOR
    end
  end

  def self.salvar_csv(cliente, classificacao)
    unless File.exist?(ARQUIVO_CSV)
      File.write(ARQUIVO_CSV, "Data;Nome;Telefone;IMC;Classificacao;TMB;Gasto_Real;Agua_litros\n")
    end

    linha = [
      data_formatada, cliente.nome, cliente.telefone, cliente.imc,
      classificacao, cliente.tmb, cliente.gasto_total, cliente.agua_diaria
    ].join(";")

    File.open(ARQUIVO_CSV, "a") { |f| f.puts linha }
  end

  def self.eliminar_do_txt(nome)
    return false unless File.exist?(ARQUIVO_TXT)
    fichas = File.read(ARQUIVO_TXT).split(DIVISOR).map(&:strip).reject(&:empty?)
    novas_fichas = fichas.reject { |f| f.downcase.include?(nome.downcase) }
    
    return false if fichas.size == novas_fichas.size

    File.open(ARQUIVO_TXT, "w") do |f|
      novas_fichas.each { |nf| f.puts "#{DIVISOR}\n#{nf}\n#{DIVISOR}" }
    end
    true
  end

  def self.eliminar_do_csv(nome)
    return false unless File.exist?(ARQUIVO_CSV)
    linhas = File.readlines(ARQUIVO_CSV)
    cabecalho = linhas.shift
    novas_linhas = linhas.reject { |l| l.downcase.include?(nome.downcase) }

    return false if linhas.size == novas_linhas.size

    File.open(ARQUIVO_CSV, "w") do |f|
      f.puts cabecalho
      f.print novas_linhas.join
    end
    true
  end
end