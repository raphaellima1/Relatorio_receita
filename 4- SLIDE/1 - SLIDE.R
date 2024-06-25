##############################################
# Criação base diaria
##############################################
index = c(3,4,1,5,6,2)

data_fim <- max(receitas_base$data)

tabela_total <- receitas_base %>% 
  mutate(mes = month(data)) %>% 
  filter(mes == month(data_fim) & Ano >= 2023) %>% 
  group_by(Ano, Tipo) %>% 
  summarise(Valor = sum(Valor)) %>% 
  pivot_wider(names_from = Ano, values_from = Valor) %>% 
  arrange(Tipo) %>% 
  mutate(index_ordem = index) %>% 
  arrange(index) %>% 
  select(1:3) %>% 
  bind_cols(receitas_base %>% 
              mutate(mes = month(data)) %>% 
              filter(Ano >= 2023) %>% 
              group_by(Ano, Tipo) %>% 
              summarise(Valor = sum(Valor)) %>% 
              pivot_wider(names_from = Ano, values_from = Valor) %>% 
              arrange(Tipo) %>% 
              mutate(index_ordem = index) %>% 
              arrange(index) %>% 
              select(2:3)) %>% 
  
  bind_cols(projecao_base %>% 
               filter(mes == month(data_fim)) %>% 
               filter(DESCRIÇÃO %in% filtro) %>% 
               mutate(DESCRIÇÃO = case_when(
                 DESCRIÇÃO == "Adicional de 2% ICMS" ~ 'Adicional 2%',
                 DESCRIÇÃO == "Contribuições ao PROTEGE" ~ 'PROTEGE',
                 DESCRIÇÃO == "Contribuição ao FUNDEINFRA" ~ 'FUNDEINFRA',
                 TRUE ~ DESCRIÇÃO)) %>% 
               arrange(DESCRIÇÃO) %>% 
               mutate(index_ordem = index) %>% 
               arrange(index) %>% 
               rename('projecao_mes' = 'Valor') %>% 
               select(4))

filtro <- c('ICMS', 'IPVA', 'Adicional de 2% ICMS', 'Contribuições ao PROTEGE',
            'Contribuição ao FUNDEINFRA', 'ITCD')

projecao_base %>% 
  filter(mes == month(data_fim)) %>% 
  filter(DESCRIÇÃO %in% filtro) %>% 
  mutate(DESCRIÇÃO = case_when(
    DESCRIÇÃO == "Adicional de 2% ICMS" ~ 'Adicional 2%',
    DESCRIÇÃO == "Contribuições ao PROTEGE" ~ 'PROTEGE',
    DESCRIÇÃO == "Contribuição ao FUNDEINFRA" ~ 'FUNDEINFRA',
    TRUE ~ DESCRIÇÃO)) %>% 
  arrange(DESCRIÇÃO) %>% 
  mutate(index_ordem = index) %>% 
  arrange(index) %>% 
  rename('projecao_mes' = 'Valor') %>% 
  select(4)
  
