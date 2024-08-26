# gráfico PIB ------------------------------------------------------------------
# CRIANDO UMA QUEBRA TRIMESTRAL DAS DATAS PROS DADOS DO PIB
breaks_trimestre <- PIB %>% 
  filter(substr(trimestre, 6, 7) == "12") %>% 
  pull(trimestre)
labels <- format(breaks_trimestre, "%Y-%m")

# CRIANDO O GRÁFICO
fig1 <- PIB %>%
# CORES DIFERENTES PARA VALORES POSITIVOS E NEGATIVOS
  ggplot(aes(x = trimestre, y = pib, fill = pib > 0)) +
  geom_bar(stat = "identity", position = position_dodge(preserve = "single")) +
# VALORES DAS BARRAS
  geom_text(aes(label = scales::label_number(decimal.mark=',',accuracy=0.1)(pib)), 
            vjust = ifelse(PIB$pib > 0, 1.5, -0.5), color = "white", 
            position = position_dodge(width = 0.7), size = 3.5, fontface = "bold") +
# CONFIGURANDO VERMELHO PARA VALORES NEGATIVOS E VERDE PARA POSITIVOS
  scale_fill_manual(guide = 'none', breaks = c(TRUE, FALSE),
                    values = c(cor2[2], cor2[3])) +
# QUEBRAS TRIMESTRAIS NO EIXO HORIZONTAL
  scale_x_date(breaks = breaks_trimestre, labels = labels) +
# TÍTULOS DOS EIXOS E DO GRÁFICO
  labs(x = "", y = "% a.a.", 
       title = glue("PIB Brasil - Var. real últimos 4 trimestres ({year(Sys.Date())-4}-{year(Sys.Date())})"), linetype = "Variable",
       color = "Variable") +
# TEMA DO GRÁFICO
  theme_classic() +
# POSICIONANDO O TÍTULO E ZERANDO AS MARGENS
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        plot.margin = margin(0, 0, 0, 0))


# criando o gráfico do IPCA ----------------------------------------------------
fig2 <- ipca %>% 
  ggplot() +
# DEFININDO AS CURVAS
  geom_line(aes(x = data, y = ipcabr12, color="Brasil"), size = 1) +
  geom_line(aes(x = data, y = ipcago12, color="Goiânia"), size = 1) +
# ESCALA DO EIXO VERTICAL E ADIÇÃO DE UM SUFIXO
  scale_y_continuous(labels=scales::label_number(decimal.mark=',',suffix='%')) +
# EDITANDO OS TÍTULOS DOS EIXOS E DO GRÁFICO
  labs(x = " ", y = "", title = glue("IPCA acum. 12 meses ({year(Sys.Date())-2}-{year(Sys.Date())})"), 
       linetype = "Variable", color = "Variable") +
# DEFININDO OS NOMES E CORES DAS CURVAS
  scale_color_manual(breaks = c('Brasil','Goiânia'), 
                     values = c('Brasil'=cor2[2],'Goiânia'=cor2[1]),name="") +
# TEMA GERAL DO GRÁFICO  
  theme_classic() +
# POSICIONAMENTO DO TÍTULO E TAMANHO DAS MARGENS
  theme(plot.title = element_text(hjust=0.5, face = "bold"),
        plot.margin = margin(0, 0, 0, 0)) +
# CONFIGURAÇÃO DA LEGENDA
  theme(legend.position=c(0.99,0.9),
        legend.key.size = unit(0.3,'cm'),
        legend.justification = c("right", "bottom"),
        legend.margin = margin(0,0,0,0)) +
# ESCALA E QUEBRAS DO EIXO HORIZONTAL
  scale_x_date(limits = c(min(ipca$data), max(ipca$data) %m +% months(1)),
               breaks=seq(max(ipca$data),min(ipca$data),by="-3 months"),
               date_labels="%b/%y") +
# ADICIONANDO OS LABELS DOS VALORES MAIS RECENTES DO IPCA DO BRASIL E DE GOIÁS
  geom_label(aes(x = last_ipca$data, y = last_ipca$ipcago12, 
                 label = paste0(format(last_ipca$ipcabr12,decimal.mark=','),'%')),vjust=0.4,hjust=0.5, colour=cor2[2]) +
  geom_label(aes(x = last_ipca$data, y = last_ipca$ipcabr12, 
                 label = paste0(format(last_ipca$ipcago12,decimal.mark=','),'%')),vjust=0.4,hjust=0.5, colour=cor2[1])



# gráfico da selic -------------------------------------------------------------
fig3 <- selic %>% 
  ggplot() +
  geom_line(aes(x=data,y=selic,color="Taxa Selic"),size = 1) +
  scale_y_continuous(labels=scales::label_number(decimal.mark=',',suffix='%')) +
  labs(x="",y="", title = glue("Selic meta definida pelo Copom ({year(Sys.Date())-2}-{year(Sys.Date())})")) +
  scale_color_manual(breaks = ('Taxa Selic'), values = ('Taxa Selic'=cor2[1]), name=" ") +
  theme_classic() +
  theme(plot.title = element_text(hjust=0.5, face = "bold"),
                        legend.title=element_blank(),legend.position='none',
                        plot.margin = margin(0, 0, 0, 0)) +
  scale_x_date(limits = c(min(selic$data), max(selic$data) %m +% months(1)),
               date_breaks='3 months',date_labels='%b/%y') +
  geom_label(aes(x = last_selic$data, y = last_selic$selic, 
                 label = paste0(format(last_selic$selic,decimal.mark=','),'%')),vjust =0.5, colour=cor2[1])


# criando o gráfico das cotações -----------------------------------------------
fig4 <- cotacao %>% 
  ggplot() +
  geom_line(aes(x = data, y = Venda_EUR, color="EUR"), size = 1) +
  geom_line(aes(x = data, y = Venda_USD, color="USD"), size = 1) +
# ADIÇÃO DE UM PREFIXO
  scale_y_continuous(labels=scales::label_number(decimal.mark=',',prefix="R$ ")) +
  labs(x="",y="", title = glue("Cotações diárias do Euro e do Dólar dos EUA ({year(Sys.Date())-2}-{year(Sys.Date())})"),
       linetype = "Variable", color = "Variable") +
  scale_color_manual(breaks = (c('EUR','USD')), values = c('EUR'= cor2[2],'USD'=cor2[1]), name=" ") +
  theme_classic() +
  scale_x_date(limits = c(min(cotacao$data), max(cotacao$data) %m +% months(0)),
               date_breaks="3 months",date_labels='%b/%y') +
  theme(plot.title = element_text(hjust=0.5, face = "bold"),
        plot.margin = margin(0, 0, 0, 0)) +
  theme(legend.position=c(0.99,0.05),
        legend.key.size = unit(0.3,'cm'),
        legend.justification = c("right", "bottom"),
        legend.margin = margin(0,0,0,0)) +
  geom_label(aes(x=last_cotacao$data,y=last_cotacao$Venda_EUR, 
                 label=paste0("R$ ",format(last_cotacao$Venda_EUR,decimal.mark=','))),
                  vjust=1,hjust=0.4,colour=cor2[2]) +
  geom_label(aes(x=last_cotacao$data,y=last_cotacao$Venda_USD, 
                 label=paste0("R$ ",format(last_cotacao$Venda_USD,decimal.mark=','))),
                  vjust =1,hjust=0.4,colour=cor2[1])

  
# figuras agrupadas
fig.allg <- ggarrange(fig1, fig2, fig3, fig4, ncol = 2, nrow = 2, common.legend = F)


# SEGUNDO CONJUNTO DE FIGURAS --------------------------------------------------
# FIGURA DESEMPREGO ------------------------------------------------------------
fig5 <- desoc %>%
  ggplot() +
  # definindo os eixos do gráfico
  geom_line(aes(x = Trimestre, y = ValorBR, color="Brasil"), size = 1) +
  geom_line(aes(x = Trimestre, y = ValorGO, color="Goiás"), size = 1) +
  # valores exibidos no eixo vertical e sufixo "%"
  scale_y_continuous(labels=scales::label_number(decimal.mark=',',suffix='%')) +
  # títulos dos eixos e da figura
  labs(x="", y = "",
       title=glue("Taxa de desemprego ({year(Sys.Date())-4}-{year(Sys.Date())})"),
       linetype='Variable',color='Variable') +
  # cores das curvas
  scale_color_manual(values = c('Brasil'=cor2[2],'Goiás'=cor2[1], name="")) +
  theme_classic() +
  # posicionamento do título e do subtítulo e o tamanho das margens
  theme(plot.title = element_text(hjust=0.5, face = "bold"),
        plot.margin = margin(0, 0, 0, 0),
        legend.title=element_blank()) +
  # limites do eixo horizontal
  scale_x_date(limits = c(min(desoc$Trimestre), max(desoc$Trimestre) %m +% months(1)),
               breaks=seq(max(desoc$Trimestre),min(desoc$Trimestre),by="-6 months"),
               date_labels="%b/%y") +
  # posicionamento e tamanho das legendas
  theme(legend.position = c(0.15,0.85), #posição horizontal e vertical da legenda
        legend.key.size = unit(0.5,'cm'),
        legend.justification = c("right", "bottom"),
        legend.margin = margin(0,0,0,0)) +
  # adicionando o rótulo dos dados mais recentes da taxa de desemprego com sufixo "%"
  geom_label(aes(x = last_desoc$Trimestre, y = last_desoc$ValorBR, 
                 label = paste0(format(last_desoc$ValorBR,decimal.mark=','),'%')),
             vjust= 0.5,hjust=0.4, colour=cor2[2]) +
  geom_label(aes(x = last_desoc$Trimestre, y = last_desoc$ValorGO, 
                 label = paste0(format(last_desoc$ValorGO,decimal.mark=','),'%')),
             vjust= 0.5,hjust=0.4, colour=cor2[1])

# GRÁFICO RENDA MÉDIA ----------------------------------------------------------
fig6 <- renda %>% 
  ggplot() +
  geom_line(aes(x = trimestre,y = rendabr,color="Brasil",group=1), size = 1) +
  geom_line(aes(x = trimestre,y = rendago,color="Goiás",group=1), size = 1) +
  scale_y_continuous(labels=scales::label_number(big.mark='.',decimal.mark=',',prefix='R$ ')) +
  labs(x="",y="",
       title=glue("PNADC trim. - Renda real média de todas as fontes ({year(Sys.Date())-4}-{year(Sys.Date())})"),
       subtitle='Deflacionado pelo último mês do trimestre da coleta',
       linetype='Variable',color='Variable') +
  scale_color_manual(values = c('Brasil'=cor2[2],'Goiás'=cor2[1], name="")) +
  theme_classic() +
  theme(plot.title = element_text(hjust=1, face = "bold"),
        plot.margin = margin(0, 0, 0, 0),
        plot.subtitle=element_text(hjust=0.25),
        legend.title=element_blank()) +
  scale_x_date(limits = c(min(renda$trimestre), max(renda$trimestre) %m +% months(3)),
               breaks=seq(max(renda$trimestre),min(renda$trimestre),by="-6 months"),
               date_labels="%b/%y") +
  theme(legend.position = c(0.15,0.85), #posição horizontal e vertical da legenda
        legend.key.size = unit(0.5,'cm'),
        legend.justification = c("right", "bottom"),
        legend.margin = margin(1,1,1,1)) +
  geom_label(aes(x = last_renda$trimestre, y = last_renda$rendabr, 
                 label = paste0("R$ ",format(last_renda$rendabr,big.mark='.',
                                             decimal.mark=','))),vjust=0.5,hjust=0.4, colour=cor2[2]) +
  geom_label(aes(x = last_renda$trimestre, y = last_renda$rendago, 
                 label = paste0("R$ ",format(last_renda$rendago,big.mark='.',
                                             decimal.mark=','))),vjust=0.5,hjust=0.4, colour=cor2[1])



# GRÁFICO DA PIM 12 MESES ------------------------------------------------------
fig7 <- pim12 %>% 
  ggplot() +
  geom_line(aes(x = mes, y = pimbr12, color="Brasil"), size = 1) +
  geom_line(aes(x = mes, y = pimgo12, color="Goiás"), size = 1) +
  scale_y_continuous(labels=scales::label_number(decimal.mark=',',suffix='%')) +
  labs(x="", y = "",
       title=glue("PIMPF Indústria geral ({year(Sys.Date())-2}-{year(Sys.Date())})"),
       subtitle="Variação acumulada em 12 meses",linetype='Variable',color='Variable') +
  scale_color_manual(values = c('Brasil'=cor2[2],'Goiás'=cor2[1], name="")) +
  theme_classic() +
  theme(plot.title = element_text(hjust=0.5, face = "bold"),
        plot.margin = margin(0, 0, 0, 0),
        plot.subtitle=element_text(hjust=0.5),
        legend.title=element_blank()) +
  scale_x_date(limits = c(min(pim12$mes), max(pim12$mes) %m +% months(1)),
               breaks=seq(max(pim12$mes),min(pim12$mes),by="-4 months"),
               date_labels="%b/%y") +
  theme(legend.position = c(0.15,0.85),
        legend.key.size = unit(0.5,'cm'),
        legend.justification = c("right", "bottom"),
        legend.margin = margin(1,1,1,1)) +
  geom_label(aes(x = last_pim12$mes, y = last_pim12$pimbr12, 
                 label = paste0(format(last_pim12$pimbr12,decimal.mark=','),'%')),
             vjust=0.5,hjust=0, colour=cor2[2]) +
  geom_label(aes(x = last_pim12$mes, y = last_pim12$pimgo12, 
                 label = paste0(format(last_pim12$pimgo12,decimal.mark=','),'%')),
             vjust=0.5,hjust=0, colour=cor2[1])

# PIM VARIAÇÃO MENSAL
fig8 <- pim %>% 
  ggplot() +
  geom_line(aes(x = mes, y = pimbr, color="Brasil"), size = 1) +
  geom_line(aes(x = mes, y = pimgo, color="Goiás"), size = 1) +
  scale_y_continuous(labels=scales::label_number(decimal.mark=',',suffix='%')) +
  labs(x="", y = "",
       title=glue("PIMPF Indústria geral ({year(Sys.Date())-2}-{year(Sys.Date())})"),
       subtitle="Variação em relação ao mês imediatamente anterior",linetype='Variable',color='Variable') +
  scale_color_manual(values = c('Brasil'=cor2[2],'Goiás'=cor2[1], name="")) +
  theme_classic() +
  theme(plot.title = element_text(hjust=0.5, face = "bold"),
        plot.margin = margin(0, 0, 0, 0),
        plot.subtitle=element_text(hjust=0.5),
        legend.title=element_blank()) +
  scale_x_date(limits = c(min(pim$mes), max(pim$mes) %m +% months(1)),
               breaks=seq(max(pim$mes),min(pim$mes),by="-4 months"),
               date_labels="%b/%y") +
  theme(legend.position = c(0.15,0.85),
        legend.key.size = unit(0.5,'cm'),
        legend.justification = c("right", "bottom"),
        legend.margin = margin(1,1,1,1)) +
  geom_label(aes(x = last_pim$mes, y = last_pim$pimbr, 
                 label = paste0(format(last_pim$pimbr,decimal.mark=','),'%')),
             vjust= 0.5,hjust=0.4, colour=cor2[2]) +
  geom_label(aes(x = last_pim$mes, y = last_pim$pimgo, 
                 label = paste0(format(last_pim$pimgo,decimal.mark=','),'%')),
             vjust= 0.5,hjust=0.4, colour=cor2[1])

# SEGUNDO CONJUNTO DE FIGURAS
fig.allg1 <- ggarrange(fig5,fig7,fig6,fig8,ncol = 2, nrow = 2, common.legend = F)


# TERCEIRO CONJUNTO DE FIGURAS -------------------------------------------------
# GRÁFICO DA PMC 12 MESES ------------------------------------------------------
fig9 <- pmc12 %>% ggplot() +
  geom_line(aes(x = mes, y = pmcbr12, color="Brasil"), size = 1) +
  geom_line(aes(x = mes, y = pmcgo12, color="Goiás"), size = 1) +
  scale_y_continuous(labels=scales::label_number(decimal.mark=',',suffix='%')) +
  labs(x="", y = "",title=glue("PMC vendas no varejo ({year(Sys.Date())-2}-{year(Sys.Date())})"),
       subtitle="Variação acumulada em 12 meses",linetype='Variable',color='Variable') +
  scale_color_manual(values = c('Brasil'=cor2[2],'Goiás'=cor2[1], name="")) +
  theme_classic() +
  theme(plot.title = element_text(hjust=0.5, face = "bold"),
        plot.margin = margin(0, 0, 0, 0),
        plot.subtitle=element_text(hjust=0.5),
        legend.title=element_blank()) +
  scale_x_date(limits = c(min(pmc12$mes), max(pmc12$mes) %m +% months(1)),
               breaks=seq(max(pmc12$mes),min(pmc12$mes),by="-4 months"),
               date_labels="%b/%y") +
  theme(legend.position = c(0.15,0.85), #posição horizontal e vertical da legenda
        legend.key.size = unit(0.5,'cm'),
        legend.justification = c("right", "bottom"),
        legend.margin = margin(1,1,1,1)) +
  geom_label(aes(x = last_pmc12$mes, y = last_pmc12$pmcbr12, 
                 label = paste0(format(last_pmc12$pmcbr12,decimal.mark=','),'%')),
             vjust=0.5,hjust=0.4, colour=cor2[2]) +
  geom_label(aes(x = last_pmc12$mes, y = last_pmc12$pmcgo12, 
                 label = paste0(format(last_pmc12$pmcgo12,decimal.mark=','),'%')),
             vjust=0.5,hjust=0.4, colour=cor2[1])

# GRÁFICO DA PMC MENSAL
fig10 <- pmc %>% ggplot() +
  geom_line(aes(x = mes, y = pmcbr, color="Brasil"), size = 1) +
  geom_line(aes(x = mes, y = pmcgo, color="Goiás"), size = 1) +
  scale_y_continuous(labels=scales::label_number(decimal.mark=',',suffix='%')) +
  labs(x="", y = "",title=glue("PMC vendas no varejo ({year(Sys.Date())-2}-{year(Sys.Date())})"),
       subtitle="Variação em relação ao mês imediatamente anterior",linetype='Variable',color='Variable') +
  scale_color_manual(values = c('Brasil'=cor2[2],'Goiás'=cor2[1], name="")) +
  theme_classic() +
  theme(plot.title = element_text(hjust=0.5, face = "bold"),
        plot.margin = margin(0, 0, 0, 0),
        plot.subtitle=element_text(hjust=0.5),
        legend.title=element_blank()) +
  scale_x_date(limits = c(min(pmc$mes), max(pmc$mes) %m +% months(1)),
               breaks=seq(max(pmc$mes),min(pmc$mes),by="-4 months"),
               date_labels="%b/%y") +
  theme(legend.position = c(0.15,0.85), #posição horizontal e vertical da legenda
        legend.key.size = unit(0.5,'cm'),
        legend.justification = c("right", "bottom"),
        legend.margin = margin(1,1,1,1)) +
  geom_label(aes(x = last_pmc$mes, y = last_pmc$pmcbr, 
                 label = paste0(format(last_pmc$pmcbr,decimal.mark=','),'%')),
             vjust=0.5,hjust=0.4, colour=cor2[2]) +
  geom_label(aes(x = last_pmc$mes, y = last_pmc$pmcgo, 
                 label = paste0(format(last_pmc$pmcgo,decimal.mark=','),'%')),
             vjust=0.5,hjust=0.4, colour=cor2[1])

# GRÁFICO DA PMS 12 MESES ------------------------------------------------------
fig11 <- pms12 %>% ggplot() +
  geom_line(aes(x = mes, y = pmsbr12, color="Brasil"), size = 1) +
  geom_line(aes(x = mes, y = pmsgo12, color="Goiás"), size = 1) +
  scale_y_continuous(labels=scales::label_number(decimal.mark=',',suffix='%')) +
  labs(x="", y = "",title=glue("PMS volume de serviços ({year(Sys.Date())-2}-{year(Sys.Date())})"),
       subtitle="Variação acumulada em 12 meses",linetype='Variable',color='Variable') +
  scale_color_manual(values = c('Brasil'=cor2[2],'Goiás'=cor2[1], name="")) +
  theme_classic() +
  theme(plot.title = element_text(hjust=0.5, face = "bold"),
        plot.margin = margin(0, 0, 0, 0),
        plot.subtitle=element_text(hjust=0.5),
        legend.title=element_blank()) +
  scale_x_date(limits = c(min(pms12$mes), max(pms12$mes) %m +% months(1)),
               breaks=seq(max(pms12$mes),min(pms12$mes),by="-4 months"),
               date_labels="%b/%y") +
  theme(legend.position = c(0.15,0.85), #posição horizontal e vertical da legenda
        legend.key.size = unit(0.5,'cm'),
        legend.justification = c("right", "bottom"),
        legend.margin = margin(1,1,1,1)) +
  geom_label(aes(x = last_pms12$mes, y = last_pms12$pmsbr12, 
                 label = paste0(format(last_pms12$pmsbr12,decimal.mark=','),'%')),
             vjust=0.5,hjust=0.4, colour=cor2[2]) +
  geom_label(aes(x = last_pms12$mes, y = last_pms12$pmsgo12, 
                 label = paste0(format(last_pms12$pmsgo12,decimal.mark=','),'%')),
             vjust=0.5,hjust=0.4, colour=cor2[1])

# PMS MENSAL
fig12 <- pms %>% ggplot() +
  geom_line(aes(x = mes, y = pmsbr, color="Brasil"), size = 1) +
  geom_line(aes(x = mes, y = pmsgo, color="Goiás"), size = 1) +
  scale_y_continuous(labels=scales::label_number(decimal.mark=',',suffix='%')) +
  labs(x="", y = "",title=glue("PMS volume de serviços ({year(Sys.Date())-2}-{year(Sys.Date())})"),
       subtitle="Variação em relação ao mês imediatamente anterior",linetype='Variable',color='Variable') +
  scale_color_manual(values = c('Brasil'=cor2[2],'Goiás'=cor2[1], name="")) +
  theme_classic() +
  theme(plot.title = element_text(hjust=0.5, face = "bold"),
        plot.margin = margin(0, 0, 0, 0),
        plot.subtitle=element_text(hjust=0.5),
        legend.title=element_blank()) +
  scale_x_date(limits = c(min(pms$mes), max(pms$mes) %m +% months(1)),
               breaks=seq(max(pms$mes),min(pms$mes),by="-4 months"),
               date_labels="%b/%y") +
  theme(legend.position = c(0.15,0.85), #posição horizontal e vertical da legenda
        legend.key.size = unit(0.5,'cm'),
        legend.justification = c("right", "bottom"),
        legend.margin = margin(1,1,1,1)) +
  geom_label(aes(x = last_pms$mes, y = last_pms$pmsbr, 
                 label = paste0(format(last_pms$pmsbr,decimal.mark=','),'%')),
             vjust= 0.5,hjust=0.4, colour=cor2[2]) +
  geom_label(aes(x = last_pms$mes, y = last_pms$pmsgo, 
                 label = paste0(format(last_pms$pmsgo,decimal.mark=','),'%')),
             vjust= 0.5,hjust=0.4, colour=cor2[1])


fig.allg2 <- ggarrange(fig9,fig11,fig10,fig12, ncol = 2, nrow = 2, common.legend = F)


