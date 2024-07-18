##############################################
# Criação base diaria
##############################################
index = c(2,4,1,5,6,3)

filtro <- c('ICMS', 'IPVA', 'Adicional de 2% ICMS', 'Contribuições ao PROTEGE',
            'Contribuição ao FUNDEINFRA', 'ITCD')


data_fim <- max(receitas_base$data)

tabela_total <- receitas_base %>% 
  mutate(mes = month(data)) %>% 
  filter(mes == month(data_fim) & Ano >= 2023) %>% 
  group_by(Ano, Tipo) %>% 
  summarise(Valor = sum(Valor)/1000000) %>% 
  pivot_wider(names_from = Ano, values_from = Valor) %>% 
  arrange(Tipo) %>% 
  mutate(index_ordem = index) %>% 
  arrange(index) %>% 
  setNames(c('Tipo', 'mes_23', 'mes_24')) %>% 
  select(1:3) %>% 
  
  add_column(col_space = NA, .name_repair = "universal") %>% 
  
  bind_cols(receitas_base %>% 
              mutate(mes = month(data)) %>% 
              filter(mes <= month(data_fim), Ano >= 2023) %>% 
              group_by(Ano, Tipo) %>% 
              summarise(Valor = sum(Valor)/1000000) %>% 
              pivot_wider(names_from = Ano, values_from = Valor) %>% 
              arrange(Tipo) %>% 
              mutate(index_ordem = index) %>% 
              arrange(index) %>%
              setNames(c('Tipo', 'acum_23', 'acum_24')) %>% 
              select(2:3)
  ) %>% 
  
  add_column(col_space = NA, .name_repair = "universal") %>% 
  
  bind_cols(projecao_base %>% 
              filter(mes == month(data_fim)) %>%
              group_by(DESCRIÇÃO) %>% 
              summarise(valor = sum(Valor)/1000000) %>% 
              filter(DESCRIÇÃO %in% filtro) %>% 
              mutate(DESCRIÇÃO = case_when(
                DESCRIÇÃO == "Adicional de 2% ICMS" ~ 'Adicional 2%',
                DESCRIÇÃO == "Contribuições ao PROTEGE" ~ 'PROTEGE',
                DESCRIÇÃO == "Contribuição ao FUNDEINFRA" ~ 'FUNDEINFRA',
                TRUE ~ DESCRIÇÃO)) %>% 
              arrange(DESCRIÇÃO) %>% 
              mutate(index_ordem = index) %>% 
              arrange(index) %>% 
              rename('projecao_mes' = 'valor') %>% 
              select(2)
  ) %>% 
  
  bind_cols(projecao_base %>% 
              filter(mes <= month(data_fim)) %>%
              group_by(DESCRIÇÃO) %>% 
              summarise(valor = sum(Valor)/1000000) %>% 
              filter(DESCRIÇÃO %in% filtro) %>% 
              mutate(DESCRIÇÃO = case_when(
                DESCRIÇÃO == "Adicional de 2% ICMS" ~ 'Adicional 2%',
                DESCRIÇÃO == "Contribuições ao PROTEGE" ~ 'PROTEGE',
                DESCRIÇÃO == "Contribuição ao FUNDEINFRA" ~ 'FUNDEINFRA',
                TRUE ~ DESCRIÇÃO)) %>% 
              arrange(DESCRIÇÃO) %>% 
              mutate(index_ordem = index) %>% 
              arrange(index) %>% 
              rename('projecao_acum' = 'valor') %>% 
              select(2)
  ) %>% 
  
  add_column(col_space = NA, .name_repair = "universal") %>%
  
  mutate(dif_mes = mes_24 - projecao_mes,
         dif_acum = acum_24 - projecao_acum) %>% 
  adorn_totals(na.rm = TRUE, fill = " ") %>% 
  setNames(c("Arrecadação", "2023", "2024", " ", ' 2023', ' 2024', "  ",
             " Mensal", " Acumulado", "   ", 'Mensal', 'Acumulado'))




tabela_acumulado <- tabela_total %>%
  flextable() %>% 
  border_remove() %>%
  padding( i=c(2,3), j=1, padding.left=15) %>% 
  colformat_double(j = c("2023", "2024", ' 2023', ' 2024',
                         " Mensal", " Acumulado"),
                   big.mark=".",
                   decimal.mark = ',', 
                   digits = 0, 
                   na_str = "--") %>% 
  
  colformat_double(j = c('Mensal', 'Acumulado'),
                   big.mark=".",
                   decimal.mark = ',', 
                   digits = 2, 
                   na_str = "--") %>% 
  color( ~ Mensal < 0, ~ Mensal,  color = cor1[4]) %>% 
  color( ~ Acumulado < 0, ~ Acumulado,  color = cor1[4]) %>% 
  set_header_labels(values = c('Arrecadação',"2023", "2024",'', '2023', '2024','',
                               "Mensal", "Acumulado",'', "Mensal", "Acumulado")) %>% 
  bg(., 
     part = "header", 
     bg = cor1[2]) %>% 
  style( pr_t = fp_text_default(
    bold = T,
    color = cor1[1]
  ),
  part = 'header') %>% 
  bg(., i= c(1,4,6), 
     part = "body", 
     bg = cor1[1]) %>% 
  
  bg(., i= ~ Arrecadação == "Total", 
     part = "body", 
     bg = cor1[2]) %>% 
  
  style(i =  ~ Arrecadação == "Total", 
        pr_t = fp_text_default(
          bold = T,
          color = cor1[1]
        )) %>% 
  hline(i = c(6,7), part = "body", 
        border =  std_border) %>% 
  add_header_row(values = c('Arrecadação', 'Mensal', '  ', "Acumulado (Ano)",
                            '   ', "Projeções", '    ', 'Diferença em R$ (Real./24) - (Proj./24)'), 
                 colwidths = c(1,2,1,2,1,2,1,2)) %>% 
  #merge_at(i = 1:2, j = 1, part = "header") %>% 
  merge_at(i = 1:2, j = 1, part = "header") %>% 
  align(i = 1, j = NULL, align = "center", part = "header") %>% 
  hline(i = 1, j = c(2,3,5,6,8,9,11,12), part = "header", 
        border =  std_border) %>% 
  width(j = c(4,7,10), width = .2, unit = 'cm') %>% 
  width(j = 1, width = 2.6, unit = 'cm') %>% 
  width(j = c(2,3,5,6,8,9,11,12), width = 2, unit = 'cm') 