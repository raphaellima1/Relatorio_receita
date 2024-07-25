excu_orcamentaria_G <- excu_orcamentaria |> 
  group_by(data) |> 
  summarise(dotação = sum(`Dotação (LOA + Créditos)`, na.rm = T),
            Empenho = sum(Empenho, na.rm = T),
            Liquidação = sum(Liquidação, na.rm = T),
            Pagamento = sum(Pagamento, na.rm = T)) |> 
  mutate(Dot = cumsum(dotação),
         Emp = cumsum(Empenho),
         Liq = cumsum(Liquidação),
         Pag = cumsum(Pagamento))


fig1 <- excu_orcamentaria_G |> 
  ggplot()+
  geom_step(aes(x = data, y = Dot, color = "Dotação",
                linetype = "Dotação"), size=1 )+
  geom_line(aes(x = data, y = Emp, color = "Empenho",
                linetype = "Empenho"), size=0.5)+
  geom_line(aes(x = data, y = Liq, color = "Liquidação",
                linetype = "Liquidação"), size=0.5)+
  geom_line(aes(x = data, y = Pag, color = "Pagamento",
                linetype = "Pagamento"), size=0.5)+
  scale_y_continuous(labels = scales::label_number(scale_cut = scales::cut_short_scale())) +
  scale_x_date(date_breaks = "2 month", date_labels = "%b") +

  scale_color_manual(breaks = c('Dotação', "Empenho", 'Liquidação', 'Pagamento'),
                   values = c("Dotação" = 'gray', "Empenho" = cor2[3], 
                              "Liquidação" = cor2[2],"Pagamento" = cor2[1]), 
                   name = "Legenda:") + 
  
  scale_linetype_manual(breaks = c('Dotação', "Empenho", 'Liquidação', 'Pagamento'),
                        values = c("Dotação" = 'solid', "Empenho" = 'solid', 
                                   "Liquidação" = 'solid',"Pagamento" = 'solid'), 
                        name = "Legenda:") +
  theme_classic2()
