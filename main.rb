require_relative 'leitor'
require_relative 'calculadora'

# Limpa o terminal
system("clear") || system("cls")

puts "======================================"
puts "       BIOSTATS - MONITOR VITAL       "
puts "======================================"

# 1. Coleta de dados
peso          = Leitor.ler_numero("Digite seu peso (kg)")
altura        = Leitor.ler_numero("Digite sua altura (m)")
idade         = Leitor.ler_numero("Digite sua idade").to_i
sexo          = Leitor.ler_texto("Digite seu sexo", ["M", "F"])

puts "\nNível de Atividade Física:"
puts "[1] Sedentario  (Pouco ou nenhum exercício)"
puts "[2] Moderado    (Exercício 3-5 dia/semana)"
puts "[3] Atleta      (Exercício intenso diário)"
nivel_atividade = Leitor.ler_texto("Escolha uma opção", ["1", "2", "3"])

# 2. Processamento
valor_imc     = Calculadora.calcular_imc(peso, altura)
classificacao = Calculadora.classificar_imc(valor_imc)
valor_tmb     = Calculadora.calcular_tmb(peso, altura, idade, sexo)
gasto_real    = Calculadora.calcular_gasto_total(valor_tmb, nivel_atividade)
p gasto_real
info_agua     = Calculadora.calcular_hidratacao(peso)

# 3. Exibição do Relatório
puts "\n" + "="*40
puts "            RELATÓRIO FINAL            "
puts "="*40
puts "IMC:              #{valor_imc} (#{classificacao})"
puts "TMB (Gasto Base): #{valor_tmb.round(2)} kcal/dia"
puts "Gasto Real:       #{gasto_real} kcal/dia"
puts "Água Diária:      #{info_agua[:litros]}L (~#{info_agua[:copos]} copos de 250ml)"
puts "="*40
puts "Status: Processamento concluído com sucesso."

print "\nDeseja salvar o relatório em um arquivo? [S/N]"
resposta = gets.chomp.upcase

if resposta == "S"
  classificacao_limpa = classificacao.gsub(/\e\[\d+m/, "").gsub(/\e\[0m/, "")
  texto_para_salvar = <<~TEXTO
  IMC:              #{valor_imc} (#{classificacao})
  TMB (Gasto Base): #{valor_tmb.round(2)} kcal/dia
  Gasto Real:       #{gasto_real} kcal/dia
  Agua Diária:      #{info_agua[:litros]}L
  TEXTO

  require_relative 'escritorio'
  Escritorio.salvar(texto_para_salvar)
  puts "Relatório salvo com sucesso em 'relatorio.txt'"
else
  puts "O relatório não foi salvo."
end