#gráfico PIB------------------------------------------------

breaks_trimestre <- PIB %>% 
  filter(substr(trimestre, 6, 7) == "12") %>% 
  pull(trimestre)

labels <- format(breaks_trimestre, "%Y-%m")

# Criar o gráfico
fig1 <- PIB %>%
  ggplot(aes(x = trimestre, y = pib, fill = pib > 0)) +
  geom_bar(stat = "identity", position = position_dodge(preserve = "single")) +
  geom_text(aes(label = round(pib, 2)), 
            vjust = ifelse(PIB$pib > 0, 1.5, -0.5), color = "white", 
            position = position_dodge(width = 0.9), size = 3.5, fontface = "bold") +
  scale_fill_manual(guide = 'none', breaks = c(TRUE, FALSE),
                    values = c("#009e3c", "#bf1e2e")) +
  scale_x_date(breaks = breaks_trimestre, labels = labels) +
  labs(x = "", y = "% a.a.", 
       title = glue("PIB Brasil - Var. real últimos 4 trimestres (2019-{year(Sys.Date())})"), linetype = "Variable",
       color = "Variable") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))



#criando o gráfico do IPCA----------------------------------

fig2<-ipca %>% ggplot()+
  geom_line(aes(x = data, y = ipcabr12, color="IPCA Brasil"), size = 1)+
  
  geom_line(aes(x = data, y = ipcago12, color="IPCA Goiânia"), size = 1)+
  
  scale_y_continuous(labels=scales::label_number(decimal.mark=','))+
  
  labs(x = " ", y = "% a.a.", title = "IPCA acum. 12 meses (2023-2024)", 
       linetype = "Variable", color = "Variable")+
  
  scale_color_manual(breaks = c('IPCA Brasil','IPCA Goiânia'), 
                     values = c('IPCA Brasil'="#009e3c",'IPCA Goiânia'="#002E54"), name=" ")+
  theme_classic()+theme(plot.title = element_text(hjust=0.5))+
  
  geom_label(aes(x = last_ipca$data, y = last_ipca$ipcago12, 
                 label = paste0("", last_ipca$ipcago12)),vjust =0, colour = "black")+
  
  geom_label(aes(x = last_ipca$data, y = last_ipca$ipcabr12, 
                 label = paste0("", last_ipca$ipcabr12)),vjust =0, colour = "black")



#gráfico da selic----------------------

fig3<-selic %>% ggplot()+
  geom_line(aes(x = data, y = selic, color="Taxa Selic"), size = 1)+
  
  scale_y_continuous(labels=scales::label_number(decimal.mark=','))+
  
  labs(x = " ", y = "% a.a.", title = "Selic definida pelo Copom", linetype = "Variable", color = "Variable")+
  scale_color_manual(breaks = ('Taxa Selic'), values = ('Taxa Selic'="#002E54"), name=" ")+
  
  theme_classic()+theme(plot.title = element_text(hjust=0.5),legend.position="none")+
  
  geom_label(aes(x = last_selic$data, y = last_selic$selic, 
                 label = paste0("", last_selic$selic)),vjust =0.5, colour = "black")


#criando o gráfico das cotações---------------------------

fig4 <- cotacao %>% 
  ggplot()+
  
  geom_line(aes(x = data, y = Venda_USD, color="USD"), size = 1)+
  
  geom_line(aes(x = data, y = Venda_EUR, color="EUR"), size = 1)+
  
  scale_y_continuous(labels=scales::label_number(decimal.mark=','))+

  labs(x = " ", y = "R$", title = "Cotações do Euro e do Dólar dos EUA (2023-2024)",
       linetype = "Variable", color = "Variable")+
  scale_color_manual(breaks = (c('USD','EUR')), values = c('USD'= "#002E54",'EUR'="#009e3c"), name=" ")+
  theme_classic()+theme(plot.title = element_text(hjust=0.5))+

  geom_label(aes(x = last_cotacao$data, y = last_cotacao$Venda_USD, 
                 label = paste0("", last_cotacao$Venda_USD)),
             vjust =1, colour = "black") +
  
  geom_label(aes(x = last_cotacao$data, y = last_cotacao$Venda_EUR, 
                 label = paste0("", last_cotacao$Venda_EUR)),
             vjust =1, colour = "black")


#figuras agrupadas---------------------------
fig.allg <- ggarrange(fig1, fig2, fig3, fig4, ncol = 2, nrow = 2, common.legend = F)

