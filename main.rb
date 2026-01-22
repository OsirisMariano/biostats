require_relative 'leitor'
require_relative 'escritorio'
require_relative 'pessoa'

# Removemos o require da calculadora pois a lógica agora está na classe Pessoa

def exibir_menu
  system("clear") || system("cls")
  puts "\n" + "=" * 30
  puts " BIO STATS - MENU PRINCIPAL"
  puts "=" * 30
  puts "[1] Novo Cálculo"
  puts "[2] Ver Histórico"
  puts "[3] Buscar Cliente"
  puts "[4] Eliminar Cliente"
  puts "[5] Sair"
  print "\nEscolha uma opção: "
end

def realizar_novo_calculo
  puts "\n--- Iniciando Novo Cálculo ---"
  
  # Coletamos os dados separadamente primeiro
  peso              = Leitor.ler_numero("Digite seu peso (kg)")
  altura            = Leitor.ler_numero("Digite sua altura (m)")
  idade             = Leitor.ler_numero("Digite sua idade").to_i
  sexo              = Leitor.ler_texto("Digite seu sexo", ["M", "F"])
  nivel_atividade   = coletar_nivel_atividade # Aqui pegamos "1", "2" ou "3"

  begin
    # CRIANDO O OBJETO: Verifique se os nomes das chaves batem com o initialize da Pessoa
    cliente = Pessoa.new(
      peso: peso,
      altura: altura,
      idade: idade,
      sexo: sexo,
      nivel_atividade: nivel_atividade # Verifique se na classe está :nivel_atividade
    )

    exibir_relatorio(cliente)
    solicitar_salvamento(cliente)

  rescue StandardError => e
    puts "\n" + "!"*40
    puts " ⚠️ Erro no processamento: #{e.message}"
    puts "!"*40
  end
end

def coletar_nivel_atividade
  puts "\nNível de Atividade: [1] Sedentario | [2] Moderado | [3] Atleta"
  Leitor.ler_texto("Escolha uma opção", ["1", "2", "3"])
end

def exibir_relatorio(cliente)
  puts "\n" + "=" * 40
  puts "            RELATÓRIO FINAL            "
  puts "=" * 40
  puts "IMC:              #{cliente.imc} (#{cliente.classificacao_imc})"
  puts "TMB (Gasto Base): #{cliente.tmb} kcal/dia"
  puts "Gasto Real:       #{cliente.gasto_total} kcal/dia"
  puts "Água Diária:      #{cliente.agua_diaria}L"
  puts "=" * 40
end

def solicitar_salvamento(cliente)
  print "\nDeseja salvar o relatório? [S/N]: "
  return unless gets.chomp.upcase == "S"

  dados_cadastro = Leitor.coletar_dados_pessoais
  cliente.nome     = dados_cadastro[:nome]
  cliente.telefone = dados_cadastro[:telefone]
  cliente.endereco = dados_cadastro[:endereco]

  if Escritorio.salvar_completo(cliente)
    puts "✅ Dados salvos com sucesso!"
  end
end

def gerenciar_exclusao
  print "\nDigite o nome para ELIMINAR: "
  nome = gets.chomp
  return if nome.empty?

  print "Tem certeza que deseja apagar os registros de '#{nome}'? [S/N]: "
  if gets.chomp.upcase == "S" && Escritorio.eliminar_por_nome(nome)
    puts "✅ Registro removido com sucesso!"
  else
    puts "❌ Operação cancelada ou registro não encontrado."
  end
end

# --- LOOP PRINCIPAL ---

loop do
  exibir_menu
  opcao = gets.chomp

  case opcao
  when "1" then realizar_novo_calculo
  when "2" then Escritorio.ler_historico
  when "3"
    print "\nDigite o nome para buscar: "
    nome = gets.chomp
    Escritorio.buscar_por_nome(nome) unless nome.empty?
  when "4" then gerenciar_exclusao
  when "5"
    puts "\nSaindo do BioStats... Até logo!"
    break
  else
    puts "\nOpção inválida!"
    sleep(1)
  end

  print "\nPressione ENTER para continuar..."
  gets
end