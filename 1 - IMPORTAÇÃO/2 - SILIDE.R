FPE <- realizado %>% 
  filter(Column1 == 'Cota-Parte do FPE') %>% 
  select(c(2, starts_with(glue('{year(Sys.Date())}')))) %>% 
  mutate(across(2:12, as.numeric)) %>% 
  pivot_longer(cols =  2:13) %>% 
  mutate(data = ymd(paste0(name, '01'))) %>% 
  setNames(c('RCL', 'name', 'realizado', 'data')) %>% 
  bind_cols(projeção %>% 
              filter(RECEITAS == 'RECEITA CORRENTE LÍQUIDA') %>% 
              select(c(1, starts_with(glue('{year(Sys.Date())}')))) %>% 
              mutate(across(2:12, as.numeric)) %>% 
              pivot_longer(cols =  2:13) %>% 
              mutate(data = ymd(paste0(name, '01'))) %>% 
              setNames(c('RCL', 'name', 'realizado', 'data')))

teste <- projeção %>% 
  filter(RECEITAS == 'RECEITA CORRENTE LÍQUIDA') %>% 
  select(c(1, starts_with(glue('{year(Sys.Date())}')))) %>% 
  mutate(across(2:12, as.numeric)) %>% 
  pivot_longer(cols =  2:13) %>% 
  mutate(data = ymd(paste0(name, '01'))) %>% 
  setNames(c('RCL', 'name', 'realizado', 'data'))