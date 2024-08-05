#gráfico PIB------------------------------------------------

fig1<-PIB %>%
  ggplot()+
  geom_bar(aes(x = data, y = Valor, fill = Valor > 0),
           stat = "identity", position = position_dodge(preserve = "single"))+
  
  geom_label(aes(x = data, y = Valor, label = Valor), stat = "identity",
             position = "identity")+
  
  scale_fill_manual(guide = FALSE, breaks = c(TRUE, FALSE),
                    values=c("#009e3c", "#bf1e2e"))+
  
  labs(x = " ", y = "Taxa em %", 
       title = "PIB - Taxa de variação real (2019-2023)", linetype = "Variable",
       color = "Variable")+theme_classic()+
  
  theme(plot.title = element_text(hjust=0.5))



#criando o gráfico do IPCA----------------------------------

fig2<-ipca %>% ggplot()+
  geom_line(aes(x = data, y = ipcabr12, color="IPCA Brasil"), size = 1)+
  
  geom_line(aes(x = data, y = ipcago12, color="IPCA Goiânia"), size = 1)+
  
  scale_y_continuous(labels=scales::label_number(decimal.mark=','))+
  
  labs(x = " ", y = "Taxa em %", title = "IPCA acum. 12 meses (2023-2024)", 
       linetype = "Variable", color = "Variable")+
  
  scale_color_manual(breaks = c('IPCA Brasil','IPCA Goiânia'), 
                     values = c('IPCA Brasil'="#009e3c",'IPCA Goiânia'="#002E54"), name=" ")+
  theme_classic()+theme(plot.title = element_text(hjust=0.5))+
  
  geom_label(aes(x = last_ipca$data, y = last_ipca$ipcago12, 
                 label = paste0("", last_ipca$ipcago12)),vjust =0, colour = "black")+
  
  geom_label(aes(x = last_ipca$data, y = last_ipca$ipcabr12, 
                 label = paste0("", last_ipca$ipcabr12)),vjust =0, colour = "black")



#gráfico das selics----------------------

fig3<-selic %>% ggplot()+
  geom_line(aes(x = data, y = selic12, color="Taxa Selic"), size = 1)+
  
  scale_y_continuous(labels=scales::label_number(decimal.mark=','))+
  
  labs(x = " ", y = "Taxa em %", title = "Selic acum. de 12 meses (2021-2024)", linetype = "Variable", color = "Variable")+
  scale_color_manual(breaks = ('Taxa Selic'), values = ('Taxa Selic'="#002E54"), name=" ")+
  
  theme_classic()+theme(plot.title = element_text(hjust=0.5),legend.position="none")+
  
  geom_label(aes(x = last_selic$data, y = last_selic$selic12, 
                 label = paste0("", last_selic$selic12)),vjust =0.5, colour = "black")


#criando o gráfico das cotações---------------------------

fig4 <- cotacao %>% 
  ggplot()+
  
  geom_line(aes(x = data, y = Venda_USD, color="USD"), size = 1)+
  
  geom_line(aes(x = data, y = Venda_EUR, color="EUR"), size = 1)+
  
  scale_y_continuous(labels=scales::label_number(decimal.mark=','))+
  
  labs(x = " ", y = "Taxa em R$", 
       title = "Cotações do Euro e do Dólar dos EUA (2023-2024)",
       linetype = "Variable", 
       color = "Variable")+
  
  scale_color_manual(breaks = (c('USD','EUR')), 
                     values = c('USD'= "#002E54",
                                'EUR'="#009e3c"), 
                     name=" ")+
  
  theme_classic()+
  
  theme(plot.title = element_text(hjust=0.5))+
  
  geom_label(aes(x = last_cotacao$data, y = last_cotacao$Venda_USD, 
                 label = paste0("", last_cotacao$Venda_USD)),
             vjust =1, colour = "black") +
  
  geom_label(aes(x = last_cotacao$data, y = last_cotacao$Venda_EUR, 
                 label = paste0("", last_cotacao$Venda_EUR)),
             vjust =1, colour = "black")


#figuras agrupadas---------------------------
fig.allg <- ggarrange(fig1, fig2, fig3, fig4, ncol = 2, nrow = 2, common.legend = F)

