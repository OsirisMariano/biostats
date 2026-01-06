require_relative 'leitor'
require_relative 'calculadora'

# Limpa o terminal para ficar mais apresentável
system("clear") || system("cls")

puts "======================================"
puts "       BIOSTATS - MONITOR VITAL       "
puts "======================================"

# Coleta de dados
peso          = Leitor.ler_numero("Digite seu peso (kg)")
altura        = Leitor.ler_numero("Digite sua altura (m)")
idade         = Leitor.ler_numero("Digite sua idade").to_i
sexo          = Leitor.ler_texto("Digite seu sexo", ["M", "F"])

# Cálculo
valor_imc     = Calculadora.calcular_imc(peso, altura)
classificacao = Calculadora.classificar_imc(valor_imc)
valor_tmb     = Calculadora.calcular_tmb(peso, altura, idade, sexo)

# Relatorio
puts "\n" + "="*38
puts " RELATÓRIO FINAL "
puts "="*38
puts "IMC:              #{valor_imc} (#{classificacao})"
puts "TMB (Gasto Base): #{valor_tmb.round(2)} kcal/dia"
puts "="*38
puts "Status: Processametno concluído com sucesso."