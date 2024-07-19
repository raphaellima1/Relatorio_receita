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


excu_orcamentaria_G |> 
  ggplot()+
  geom_step(aes(x = data, y = Dot, color = "Dotação",
                linetype = "Dotação"), size=0.5 )+
  geom_line(aes(x = data, y = Emp, color = "Empenho",
                linetype = "Empenho"))+
  geom_line(aes(x = data, y = Liq, color = "Liquidação",
                linetype = "Liquidação"))+
  geom_line(aes(x = data, y = Pag, color = "Pagamento",
                linetype = "Pagamento"))
