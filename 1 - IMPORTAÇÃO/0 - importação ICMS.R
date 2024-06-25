setwd("./../")
setwd('./0 - DADOS/')


########################################
# tabela do ICMS 
#########################################

ICMS_base <- read_excel("ICMS_TOTAL_2024.xlsx", 
                        sheet = "ICMS", 
                        col_types = c("text", "text", "numeric", "text", "numeric")) %>% 
  setNames(c('Tipo', 'Grupo', 'data','Ano', 'Valor')) %>% 
  mutate(data = ymd(data), Ano = year(data), Tipo = 'ICMS')


########################################
# Tabela do Adicional de 2% 
#########################################

ADD2_base <- read_excel("ICMS_TOTAL_2024.xlsx", 
                        sheet = "Adicional_2%", 
                        col_types = c("text","text", "numeric", "text", "numeric")) %>% 
  setNames(c('Tipo', 'Grupo', 'data','Ano', 'Valor')) %>% 
  select(Tipo, data,Ano, Valor) %>% 
  mutate(Tipo = 'Adicional 2%') %>% 
  mutate(data = ymd(data), Ano = year(data))

########################################
# Tabela do PROTEGE
########################################

PROTEGE_base <- read_excel("ICMS_TOTAL_2024.xlsx", 
                           sheet = "PROTEGE", 
                           col_types = c("text", "text", "numeric", "text", "numeric")) %>% 
  setNames(c('Tipo', 'Grupo', 'data','Ano', 'Valor')) %>% 
  select(Tipo, data, Ano, Valor) %>% 
  mutate(data = ymd(data), Ano = year(data), Tipo = 'PROTEGE') 

########################################
# Tabela do IPVA
########################################

IPVA_base <- read_excel("ICMS_TOTAL_2024.xlsx", 
                        sheet = "IPVA", 
                        col_types = c("text", "text", "numeric", "text", "numeric")) %>% 
  setNames(c( 'Tipo', 'Grupo', 'data','Ano', 'Valor')) %>%  
  drop_na() %>% 
  select(Tipo, data, Ano, Valor) %>% 
  mutate(data = ymd(data), Ano = year(data), Tipo = 'IPVA')

########################################
# Tabela do ITCD
########################################

ITCD_base <- read_excel("ICMS_TOTAL_2024.xlsx", 
                        sheet = "ITCD", 
                        col_types = c("text", "text", "numeric", "text", "numeric")) %>% 
  setNames(c( 'Tipo', 'Grupo', 'data','Ano', 'Valor')) %>% 
  drop_na() %>% 
  select(Tipo, data, Ano, Valor) %>% 
  mutate(data = ymd(data), Ano = year(data), Tipo = 'ITCD')

########################################
# Tabela do FUNDEINFRA
########################################
FUNDEINFRA_base <- read_excel("ICMS_TOTAL_2024.xlsx", 
                        sheet = "FUNDEINFRA", 
                        col_types = c("text", "text", "numeric", "text", "numeric")) %>% 
  setNames(c( 'Tipo', 'Grupo', 'data','Ano', 'Valor')) %>% 
  drop_na() %>% 
  select(Tipo, data, Ano, Valor) %>% 
  mutate(data = ymd(data), Ano = year(data), Tipo = 'FUNDEINFRA')


########################################
# Tabela TOTAL DAS RECEITAS TRIBUTÁRIAS
########################################

receitas_base <- ICMS_base %>% 
  select(Tipo, data,Ano, Valor) %>% 
  rbind(ADD2_base) %>% 
  rbind(PROTEGE_base) %>% 
  rbind(IPVA_base) %>% 
  rbind(ITCD_base) %>% 
  rbind(FUNDEINFRA_base)

########################################
# Tabela Projeções
########################################

projecao_base <- read_excel("Previsão_receitas_tributarias.xlsx", sheet = 2) %>% 
  pivot_longer(cols = Janeiro:Dezembro) %>% 
  mutate(Valor = as.numeric(gsub( ",", ".",value)),
         mes = case_when(
           name == "Janeiro" ~ 1,
           name == "Fevereiro" ~ 2,
           name == "Março" ~ 3,
           name == "Abril" ~ 4,
           name == "Maio" ~ 5,
           name == "Junho" ~ 6,
           name == "Julho" ~ 7,
           name == "Agosto" ~ 8,
           name == "Setembro" ~ 9,
           name == "Outubro" ~ 10,
           name == "Novembro" ~ 11,
           name == "Dezembro" ~ 12,
           TRUE ~ NA_real_
         ),
         ano = 2024) 


setwd("./../")

