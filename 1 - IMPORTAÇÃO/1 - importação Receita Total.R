setwd("./../")
setwd('./0 - DADOS/')



########################################
# tabela do Realizado
#########################################

realizado <- read_excel('RECEITA_LIQUIDA_MONITOR_20240219.xlsx', sheet = 'realizado')

projeção <- read_excel('Previsão_da_Receita_PLDO_2025_cenario_320_realizado_202401_v3 (1).xlsx', sheet = 'PREVISÃO RCL (MENSAL)')

projeção1 <- read_excel('RECEITA_LIQUIDA_MONITOR_20240219.xlsx', sheet = 'GERENCIAL295')

setwd("./../")