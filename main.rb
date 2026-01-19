require_relative 'leitor'
require_relative 'calculadora'
require_relative 'escritorio'
require_relative 'pessoa'

loop do
  # O clear fica aqui para o menu sempre aparecer "do zero"
  system("clear") || system("cls")

  puts "\n" + "="*30
  puts " BIO STATS - MENU PRINCIPAL"
  puts "="*30
  puts "[1] Novo Cálculo"
  puts "[2] Ver Histórico"
  puts "[3] Buscar cliente por nome"
  puts "[4] Sair"
  print "\nEscolha uma opção: "
  opcao = gets.chomp

  case opcao
  when "1"
    puts "\n --- Iniciando Novo Cálculo ---"
    
    # 1. Coleta e Processamento (Tudo direto e organizado)
    peso            = Leitor.ler_numero("Digite seu peso (kg)")
    altura          = Leitor.ler_numero("Digite sua altura (m)")
    idade           = Leitor.ler_numero("Digite sua idade").to_i
    sexo            = Leitor.ler_texto("Digite seu sexo", ["M", "F"])
    
    puts "\nNível de Atividade Física: [1] Sedentario | [2] Moderado | [3] Atleta"
    nivel_atividade = Leitor.ler_texto("Escolha uma opção", ["1", "2", "3"])

    cliente = Pessoa.new(
      peso: peso,
      altura: altura,
      idade: idade,
      sexo: sexo,
      nivel_atividade: nivel_atividade
    )
    # valor_imc     = Calculadora.calcular_imc(peso, altura)
    # classificacao = Calculadora.classificar_imc(valor_imc)
    # valor_tmb     = Calculadora.calcular_tmb(peso, altura, idade, sexo)
    # gasto_real    = Calculadora.calcular_gasto_total(valor_tmb, nivel_atividade)
    # info_agua     = Calculadora.calcular_hidratacao(peso)

    # 2. Exibição
    puts "\n" + "="*40
    puts "            RELATÓRIO FINAL            "
    puts "="*40
    puts "IMC: #{cliente.imc}(#{cliente.classificacao_imc})"
    puts "TMB (Gasto Base): #{cliente.tmb} kcal/dia"
    puts "Água Real: #{cliente.gasto_total} kcal/dia"
    puts "Água Diária: #{cliente.agua_diaria}L"
    puts "="*40
    
    # puts "\n" + "="*40
    # puts "            RELATÓRIO FINAL            "
    # puts "="*40
    # puts "IMC:              #{valor_imc} (#{classificacao})"
    # puts "TMB (Gasto Base): #{valor_tmb.round(2)} kcal/dia"
    # puts "Gasto Real:       #{gasto_real} kcal/dia"
    # puts "Água Diária:      #{info_agua[:litros]}L (~#{info_agua[:copos]} copos de 250ml)"
    # puts "="*40

    # 3. Salvamento (Tratado para salvar texto limpo)
    print "\nDeseja salvar o relatório? [S/N]: "
    if gets.chomp.upcase == "S"
      dados_pessoais = Leitor.coletar_dados_pessoais

      cliente.nome      = dados_pessoais[:nome]
      cliente.telefone  = dados_pessoais[:telefone]
      cliente.endereco  = dados_pessoais[:endereco]

      # Limpa as cores ANSI antes de salvar no TXT
      classificacao_limpa = cliente.classificacao_imc.gsub(/\e\[\d+m/, "").gsub(/\e\[0m/, "")
      
      texto_para_salvar = <<~TEXTO
      Nome:           #{cliente.nome}
      Tel:            #{cliente.telefone}
      End:            #{cliente.endereco}
      --------------------------------------------
      IMC:          #{cliente.imc} (#{classificacao_limpa})
      TMB:          #{cliente.tmb} kcal/dia
      Gasto Real:   #{cliente.gasto_total} kcal/dia
      Agua Diária:  #{cliente.agua_diaria} L
      TEXTO

      Escritorio.salvar(texto_para_salvar)

      pacote_para_salvar_csv = {
        nome: cliente.nome,
        telefone: cliente.telefone,
        imc: cliente.imc,
        classificacao: classificacao_limpa,
        tmb: cliente.tmb,
        gasto_real: cliente.gasto_total,
        agua: cliente.agua_diaria
      }
      Escritorio.salvar_csv(pacote_para_salvar_csv)
      puts "Salvado em TXT e CSV com sucesso!"
    end
    print "\nPressione ENTER para voltar ao menu..."
    gets # Pausa essencial

  when "2"
    system("clear") || system("cls")
    Escritorio.ler_historico
    print "\nPressione ENTER para voltar ao menu..."
    gets # Pausa essencial

  when "3"
    print "\nDigite o nome para buscar: "
    nome_procurado = gets.chomp

    if nome_procurado.empty?
      puts "Digite um nome para pesquisar."
    else
      system("clear") || system("cls")
      Escritorio.buscar_por_nome(nome_procurado)
    end

    print "\nPressione ENTER para voltar ao menu..."
    gets
  
  when "4"
    puts "\nSaindo do BioStats até logo!"
    break
  else
    puts "\nOpção inválida! Tente 1 a 3."
    sleep(1.5) # Pausa curta automática para o usuário ver o erro
  end
end
