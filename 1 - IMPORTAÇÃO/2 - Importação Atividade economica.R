#importando a série do PIB----------------------------------
PIB<-get_series(7326,start_date='2019-01-01')%>%
  setNames(c('data','Valor'))

#importando a série do ipca---------------------------------
ipcabr<-get_series(433,start_date='2022-01-02')%>%
  setNames(c('data','ValorBR'))

ipcabr$ipcabr12<-round(rollapply(ipcabr$ValorBR,12,function(x)(prod(1+x/100)-1)*100,by.column=F,align='right',fill=NA),2)
ipcabr<-ipcabr%>%
  filter(!is.na(ipcabr12))
#importando o IPCA de Goiânia

ipcago<-get_series(13255,start_date='2022-01-02')%>%
  setNames(c('data','ValorGO'))

ipcago$ipcago12<-round(rollapply(ipcago$ValorGO,12,function(x)(prod(1+x/100)-1)*100,by.column=F,align='right',fill=NA),2)

ipcago<-ipcago%>%
  filter(!is.na(ipcago12))
#mesclando os dois IPCAs
ipca<-ipcabr%>%
  merge(ipcago,by='data')%>%
  select('data','ipcabr12','ipcago12')
last_ipca <- ipca %>%
  filter(data == max(data))


#taxa de juros Selic----------------
selic<-get_series(4390,start_date='2020-01-02')%>%
  setNames(c('data','Selic'))
selic$selic12<-round(rollapply(selic$Selic,12,function(x)(prod(1+x/100)-1)*100,by.column=F,align='right',fill=NA),2)
selic<-selic%>%
  filter(!is.na(selic12))
last_selic <- selic %>%
  filter(data == max(data))


#taxas de câmbio-------------------------
#importando os dados do Dólar dos EUA e do Euro--------------------------
dolar<-get_currency('USD',start_date = '2023-01-01',end_date = Sys.Date())%>%
  setNames(c('data','Venda_USD','Compra_USD'))
euro<-get_currency('EUR',start_date = '2023-01-01',end_date=Sys.Date())%>%
  setNames(c('data','Venda_EUR','Compra_EUR'))
cotacao<-dolar%>%
  merge(euro,by='data')%>%
  select('data','Venda_USD','Venda_EUR')%>%
  mutate(Venda_USD=round(Venda_USD,2),Venda_EUR=round(Venda_EUR,2))
last_cotacao <- cotacao %>% filter(data == max(data))