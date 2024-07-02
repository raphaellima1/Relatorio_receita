fig1 <- RCL %>% 
  ggplot()+
  geom_line(aes(x = data, y = acum_23*1000000, color = "Acumulado 2023", 
                linetype = "Acumulado 2023"), size=1) +
  
  geom_line(aes(x = data, y = acum_24*1000000, color = "Acumulado 2024", 
                linetype = "Acumulado 2024"), size=1) +
  
  geom_line(aes(x = data, y = proj_acum*1000000, color = "Projeção 2024", 
                linetype = "Projeção 2024"), size=1) +
  
  labs(x = "  ", 
       y = "Valores em Reais (R$)", 
       title = "RCL ACUMULADA",
       linetype = "Variable",
       color = "Variable") +
  
  scale_y_continuous(labels=scales::label_number(scale_cut = scales::cut_short_scale())) +
  
  scale_x_date(date_breaks = "2 month", 
               date_labels = "%b")+
  scale_color_manual(breaks = c('Acumulado 2023', "Acumulado 2024", 'Projeção 2024'),
                     values = c("Acumulado 2024"="#940f0f",
                                "Acumulado 2023"="#1e5cda",
                                "Projeção 2024"="#dc2d2d"), 
                     name="Legenda:")+
  scale_linetype_manual(breaks = c('Acumulado 2023', "Acumulado 2024", 'Projeção 2024'),
                        values = c("Acumulado 2024"='solid',
                                   "Acumulado 2023"='solid',
                                   "Projeção 2024"='longdash'), 
                        name="Legenda:")+
  
  labs(fill = "Title") +
  theme_hc() + 
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank(),
    legend.position = "bottom"
  )



fig2 <- RCL %>% 
  ggplot()+
  geom_line(aes(x = data, y = RCL_2023, color = "Acumulado 2023", 
                linetype = "Acumulado 2023"), size=1) +
  
  geom_line(aes(x = data, y = RCL_2024, color = "Acumulado 2024", 
                linetype = "Acumulado 2024"), size=1) +
  
  geom_line(aes(x = data, y = Projeção_RCL, color = "Projeção 2024", 
                linetype = "Projeção 2024"), size=1) +
  
  labs(x = "  ", 
       y = "Valores em Reais (R$)", 
       title = "RCL MENSAL",
       linetype = "Variable",
       color = "Variable") +
  
  scale_y_continuous(labels=scales::label_number(scale_cut = scales::cut_short_scale())) +
  
  scale_x_date(date_breaks = "2 month", 
               date_labels = "%b")+
  scale_color_manual(breaks = c('Acumulado 2023', "Acumulado 2024", 'Projeção 2024'),
                     values = c("Acumulado 2024"="#940f0f",
                                "Acumulado 2023"="#1e5cda",
                                "Projeção 2024"="#dc2d2d"), 
                     name="Legenda:")+
  scale_linetype_manual(breaks = c('Acumulado 2023', "Acumulado 2024", 'Projeção 2024'),
                        values = c("Acumulado 2024"='solid',
                                   "Acumulado 2023"='solid',
                                   "Projeção 2024"='longdash'), 
                        name="Legenda:")+
  
  labs(fill = "Title") +
  theme_hc() + 
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank(),
    legend.position = "bottom"
  )

fig.allg <- ggarrange(fig1, fig2, ncol = 2, nrow = 1, common.legend = T, legend = "bottom")

setwd("./../")