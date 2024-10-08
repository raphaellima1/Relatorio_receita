
filtro <- c('ICMS', 'IPVA', 'Adicional de 2% ICMS', 'Contribuições ao PROTEGE',
            'Contribuição ao FUNDEINFRA', 'ITCD')

# CONSTRUINDO A TABELA COM OS DADOS
tabela_graf_total <- receitas_base %>% 
# CRIANDO UMA COLUNA COM OS MESES
  mutate(mes = month(data)) %>%
# FILTRANDO PARA ANO MAIOR OU IGUAL A T-1
  filter(Ano >= year(data_fim)-1) %>% 
# AGRUPANDO POR MÊS/ANO
  group_by(mes, Ano) %>%
# REALIZANDO A SOMA DOS VALORES POR MÊS/ANO
  summarise(Valor = sum(Valor)) %>% 
# TRANSPONDO A TABELA: ANO VIROU COLUNA
  pivot_wider(names_from = 'Ano', values_from = Valor) %>% 
  setNames(c('mes', 'ano_23', 'ano_24')) %>% 
# CRIANDO AS COLUNAS DE DATA, VALORES PROJETADOS E BANDAS SUPERIOR E INFERIOR
    bind_cols(new_projecoes |> 
              mutate(data = ym(`ANOMES REFERENCIA`)) |> 
              group_by(data) |> 
              summarise(valor = sum(`VALOR PROJECAO`, na.rm = T),
                        lim_sup = sum(`LIMITE SUPERIOR`, na.rm = T),
                        lim_inf = sum(`LIMITE INFERIOR`, na.rm = T)) |> 
              filter(year(data) == '2024')) %>% 
  mutate(data = as.Date(paste0('2024-', mes, '-', '01'))) 

# CALCULANDO OS ACUMULADOS DO ANO DE T, T-1, PROJETADO PARA T E OS LIMITES SUPERIOR E INFERIOR
tabela_graf_total$acum_23 <- cumsum(tabela_graf_total$ano_23)
tabela_graf_total$acum_24 <- cumsum(tabela_graf_total$ano_24)
tabela_graf_total$acum_proj <- cumsum(tabela_graf_total$valor)
tabela_graf_total$acum_lim_s <- cumsum(tabela_graf_total$lim_sup)
tabela_graf_total$acum_lim_inf <- cumsum(tabela_graf_total$lim_inf)


fig1 <- tabela_graf_total %>% 
  mutate(fant_24 = sub("\\.", ",", round(acum_24 / 1000000000, digits = 2))) |> 
  ggplot() +
# PLOTE DO INTERVALO DE CONFIANÇA DA PROJEÇÃO
  geom_ribbon(aes(x = data, ymin = acum_lim_inf, ymax = acum_lim_s), fill = "grey80", alpha = 0.5) +
# LINHAS DOS VALORES REALIZADOS EM T-1 E T, E DOS VALORES PROJETADOS PRA T
  geom_line(aes(x = data, y = acum_proj, color = "Projeção 2024", 
                linetype = "Projeção 2024"), size=0.5) +
  geom_line(aes(x = data, y = acum_23, color = "Acumulado 2023", 
                linetype = "Acumulado 2023"), size=0.5) +
  geom_line(aes(x = data, y = acum_24, color = "Acumulado 2024", 
                linetype = "Acumulado 2024"), size=1) +
# ADICIONANDO OS LABOLS DOS VALORES ACUMULADOS EM T
  geom_label(aes(x = data, y = acum_24, label = fant_24),vjust = -0.7,colour = cor2[1]) +
  labs(x = "  ", 
       y = "Valores em R$", 
       title = "Receitas tributárias acumuladas",
       linetype = "Variable",
       color = "Variable") +
# EDITANDO A ESCALA DOS VALORES
  scale_y_continuous(labels=scales::label_number(scale_cut = scales::cut_short_scale())) +
# EDITANDO OS RÓTULOS DO EIXO HORIZONTAL E ALTERANDO AS CORES DAS CURVAS  
  scale_x_date(date_breaks = "2 month", 
               date_labels = "%b")+
  scale_color_manual(breaks = c('Acumulado 2023', "Acumulado 2024", 'Projeção 2024'),
                     values = c("Acumulado 2024"= cor2[1],
                                "Acumulado 2023"= cor2[2],
                                "Projeção 2024"=  cor2[3]), 
                     name="Legenda:") +
# EDITANDO O FORMATO DAS CURVAS  
  scale_linetype_manual(breaks = c('Acumulado 2023', "Acumulado 2024", 'Projeção 2024'),
                        values = c("Acumulado 2024"='solid',
                                   "Acumulado 2023"='solid',
                                   "Projeção 2024"='longdash'), 
                        name="Legenda:") +
  labs(fill = "Title") +  
# EDITANDO O TEMA E COR DE FUNDO DO GRÁFICO
  theme_hc() +
# ALTERANDO O POSICIONAMENTO DO TÍTULO E DA LEGENDA  
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank(),
    legend.position = "bottom"
  )

rm(filtro)
