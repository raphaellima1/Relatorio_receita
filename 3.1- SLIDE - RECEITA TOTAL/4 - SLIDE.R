# all_dates <- seq(ymd('2022-01-01'), ymd('2024-12-01'), by = 'month') %>%
#   as_tibble() %>%
#   mutate(name = format(value, "%Y%m")) %>%
#   rename(data = value)
# 
# RCL12 <- realizado %>% 
#   filter(RECEITAS == 'RECEITA CORRENTE LÍQUIDA') %>% 
#   select(1, 4:120) %>% 
#   pivot_longer(cols = 2:118) %>% 
#   drop_na() %>%
#   select(name, value) %>% 
#   mutate(
#     RCL12 = rollsum(value, 12, fill = NA, align = "right"),
#     data = ymd(paste0(name, '01')),
#     across(where(is.numeric), ~ na_if(., 0.0)),
#     ano = year(data)) %>% 
#   drop_na()
# 
# df_2023 <- RCL12 %>% filter(ano == 2023) %>% select(RCL12)
# df_2024 <- RCL12 %>% filter(ano == 2024) %>% select(RCL12)
# 
# # Encontrar o comprimento máximo
# max_length <- max(nrow(df_2023), nrow(df_2024))
# 
# # Preencher as colunas menores com NA
# df_2023 <- rbind(df_2023, data.frame(RCL12 = rep(NA, max_length - nrow(df_2023))))
# df_2024 <- rbind(df_2024, data.frame(RCL12 = rep(NA, max_length - nrow(df_2024))))
# 
# # Combinar as colunas em um único data frame
# df_combined <- data.frame( value_2023 = df_2023$RCL12, value_2024 = df_2024$RCL12)
# 
# 
# 
# projeção_RCL <- projeção %>% 
#   filter(ESPECIFICAÇÃO == 'RECEITA CORRENTE LÍQUIDA (III) = (I-II)') %>% 
#   select(c(1, starts_with(glue('{year(Sys.Date())}')))) %>% 
#   mutate(across(2:13, as.numeric)) %>% 
#   pivot_longer(cols =  2:13) %>% 
#   mutate(data = ymd(paste0(name, '01'))) %>% 
#   select(value) %>% 
#   setNames('Projeção_RCL')


RCL <- realizado %>% 
  filter(RECEITAS == 'RECEITA CORRENTE LÍQUIDA') %>% 
  select(c(1, starts_with(glue('{year(Sys.Date())}')))) %>% 
  mutate(across(2:13, ~ na_if(as.numeric(.), 0.00))) %>% 
  pivot_longer(cols =  2:13) %>% 
  mutate(data = ymd(paste0(name, '01'))) %>% 
  setNames(c('RCL', 'name', 'RCL_2024', 'data')) %>% 
  bind_rows(realizado %>% 
              filter(RECEITAS == 'RECEITA CORRENTE LÍQUIDA') %>% 
              select(c(1, starts_with(glue('{year(Sys.Date())-1}')))) %>% 
              mutate(across(2:13, ~ na_if(as.numeric(.), 0.00))) %>% 
              pivot_longer(cols =  2:13) %>% 
              mutate(data = ymd(paste0(name, '01'))) %>% 
              setNames(c('RCL', 'name', 'RCL_2024', 'data'))) %>% 
  arrange(data) %>% 
  mutate(RCL12 = rollsum(RCL_2024, 12, fill = NA, align = "right"),
         ano = year(data)) %>% 
  filter(ano == 2024) %>% 
  select(data, RCL12) %>% 
  bind_cols(realizado %>% 
              filter(RECEITAS == 'RECEITA CORRENTE LÍQUIDA') %>% 
              select(c(1, starts_with(glue('{year(Sys.Date())-1}')))) %>% 
              mutate(across(2:13, ~ na_if(as.numeric(.), 0.00))) %>% 
              pivot_longer(cols =  2:13) %>% 
              mutate(data = ymd(paste0(name, '01'))) %>% 
              setNames(c('RCL', 'name', 'RCL_2024', 'data')) %>% 
              bind_rows(projeção %>% 
                          filter(ESPECIFICAÇÃO == 'RECEITA CORRENTE LÍQUIDA (III) = (I-II)') %>% 
                          select(c(1, starts_with(glue('{year(Sys.Date())}')))) %>% 
                          mutate(across(2:13, as.numeric)) %>% 
                          pivot_longer(cols =  2:13) %>% 
                          mutate(data = ymd(paste0(name, '01')),
                                 CAMPO = as.character(CAMPO)) %>% 
                          setNames(c('RCL', 'name', 'RCL_2024', 'data'))) %>% 
              arrange(data) %>% 
              mutate(RCL12 = rollsum(RCL_2024, 12, fill = NA, align = "right"),
                     ano = year(data)) %>% 
              filter(ano == 2024) %>% 
              select(RCL12))
  
  
