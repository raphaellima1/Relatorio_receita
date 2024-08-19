

start_data<-paste0(year(Sys.Date())-2,glue("-{month(Sys.Date())}-01"))
start_data1<-paste0(year(Sys.Date())-3,glue("-{month(Sys.Date())}-01"))

# importando a série do PIB ----------------------------------------------------
PIB <- get_sidra(5932, variable=6562, period=c("last" = 16)) %>%
  select('Valor', 'Trimestre (Código)', 'Setores e subsetores (Código)') %>%
  setNames(c('pib', 'trimestre', 'setores')) %>%
  filter(setores == '90707') %>%
  mutate(trimestre = case_when(
    substr(trimestre, 5, 6) == "01" ~ paste0(substr(trimestre, 1, 4), "-03-01"),
    substr(trimestre, 5, 6) == "02" ~ paste0(substr(trimestre, 1, 4), "-06-01"),
    substr(trimestre, 5, 6) == "03" ~ paste0(substr(trimestre, 1, 4), "-09-01"),
    substr(trimestre, 5, 6) == "04" ~ paste0(substr(trimestre, 1, 4), "-12-01"))) %>%
  mutate(trimestre = ymd(trimestre))

# IMPORTANDO AS SÉRIES DO IPCA DO BRASIL E DE GOIÂNIA --------------------------
ipca<-merge(gbcbd_get_series(433,first.date=start_data1) %>% 
            setNames(c('data','ValorBR'))%>%
            select(data,ValorBR) |> 
            mutate(ipcabr12 = round(rollapply(
                    ValorBR,12,function(x)(prod(1+x/100)-1)*100,
                    by.column=F,align='right',fill=NA),2)) |> 
            filter(!is.na(ipcabr12)),
            get_series(13255,start_date=start_data1) %>%
            setNames(c('data','ValorGO')) %>%
            mutate(ipcago12=round(rollapply(ValorGO,12,
                                            function(x)(prod(1+x/100)-1)*100,
                                            by.column=F,align='right',fill=NA),2)) %>%
            filter(!is.na(ipcago12)),
            by='data') %>%
      select('data','ipcago12','ipcabr12')

last_ipca <- ipca %>%
  filter(data == max(data))

# taxa de juros Selic ----------------------------------------------------------
selic<-get_series(432,start_date=start_data) %>% setNames(c('data','selic'))

last_selic <- selic %>%
  filter(data == max(data))


# taxas de câmbio --------------------------------------------------------------
# importando os dados do Dólar dos EUA e do Euro
dolar<-get_currency('USD',start_date = start_data,end_date = Sys.Date()) %>%
  setNames(c('data','Venda_USD','Compra_USD'))

euro<-get_currency('EUR',start_date = start_data,end_date=Sys.Date()) %>%
  setNames(c('data','Venda_EUR','Compra_EUR'))

cotacao<-dolar%>%
  merge(euro,by='data')%>%
  select('data','Venda_USD','Venda_EUR')%>%
  mutate(Venda_USD=round(Venda_USD,2),Venda_EUR=round(Venda_EUR,2))


last_cotacao <- cotacao %>% filter(data == max(data))


# DADOS DESEMPREGO -------------------------------------------------------------
# definindo a tabela, a variável,o período e a nível de agregação "estado" dos dados
desocgo<-get_sidra(6468,4099,period=c('last'=16),geo='State') %>%
  select('Valor','Unidade da Federação (Código)','Trimestre (Código)') %>%
  setNames(c('ValorGO','UF','Trimestre')) %>%
  # filtrando para GO
  filter(UF==52) %>%
  # renomeando os meses para o padrão de trimestre
  mutate(Trimestre = case_when(
    substr(Trimestre, 5, 6) == "01" ~ paste0(substr(Trimestre, 1, 4), "-03-01"),
    substr(Trimestre, 5, 6) == "02" ~ paste0(substr(Trimestre, 1, 4), "-06-01"),
    substr(Trimestre, 5, 6) == "03" ~ paste0(substr(Trimestre, 1, 4), "-09-01"),
    substr(Trimestre, 5, 6) == "04" ~ paste0(substr(Trimestre, 1, 4), "-12-01"))) %>%
  mutate(Trimestre = ymd(Trimestre))

# fazendo a mesma coisa feita acima, puxando os dados do Brasil diretamente da get_sidra
desocbr<-get_sidra(6468,4099,period=c('last'=16),geo='Brazil') %>%
  select('Valor','Trimestre (Código)') %>%
  setNames(c('ValorBR','Trimestre')) %>%
  mutate(Trimestre = case_when(
    substr(Trimestre, 5, 6) == "01" ~ paste0(substr(Trimestre, 1, 4), "-03-01"),
    substr(Trimestre, 5, 6) == "02" ~ paste0(substr(Trimestre, 1, 4), "-06-01"),
    substr(Trimestre, 5, 6) == "03" ~ paste0(substr(Trimestre, 1, 4), "-09-01"),
    substr(Trimestre, 5, 6) == "04" ~ paste0(substr(Trimestre, 1, 4), "-12-01"))) %>%
  mutate(Trimestre = ymd(Trimestre))

# mesclando os valores da PIM de Goiás e do Brasil num mesmo data frame
desoc<-desocgo %>%
  merge(desocbr,by='Trimestre') %>%
  select('Trimestre','ValorGO','ValorBR')

# filtrando o trimestre para o valor mais recente
last_desoc<-desoc %>% filter(Trimestre==max(Trimestre))

# RENDA MÉDIA ------------------------------------------------------------------
rendabr<-get_sidra(6469,5935,period=c('last'=16),geo='Brazil') %>%
  select('Valor','Trimestre (Código)','Variável (Código)','Variável') %>%
  setNames(c('rendabr','trimestre','código','variável')) %>%
  mutate(trimestre = case_when(
    substr(trimestre, 5, 6) == "01" ~ paste0(substr(trimestre, 1, 4), "-03-01"),
    substr(trimestre, 5, 6) == "02" ~ paste0(substr(trimestre, 1, 4), "-06-01"),
    substr(trimestre, 5, 6) == "03" ~ paste0(substr(trimestre, 1, 4), "-09-01"),
    substr(trimestre, 5, 6) == "04" ~ paste0(substr(trimestre, 1, 4), "-12-01"))) %>%
  mutate(trimestre = ymd(trimestre))
rendago<-get_sidra(6469,5935,period=c('last'=16),geo='State') %>%
  select('Valor','Unidade da Federação (Código)','Trimestre (Código)',
         'Variável (Código)','Variável') %>%
  setNames(c('rendago','uf','trimestre','código','variável')) %>%
  mutate(trimestre = case_when(
    substr(trimestre, 5, 6) == "01" ~ paste0(substr(trimestre, 1, 4), "-03-01"),
    substr(trimestre, 5, 6) == "02" ~ paste0(substr(trimestre, 1, 4), "-06-01"),
    substr(trimestre, 5, 6) == "03" ~ paste0(substr(trimestre, 1, 4), "-09-01"),
    substr(trimestre, 5, 6) == "04" ~ paste0(substr(trimestre, 1, 4), "-12-01"))) %>%
  filter(uf==52) %>%
  mutate(trimestre = ymd(trimestre))

renda<-rendabr %>%
  merge(rendago,by='trimestre') %>%
  select('trimestre','rendabr','rendago')

last_renda <- renda %>%
  filter(trimestre == max(trimestre))


# DADOS DA PIM ACUMULADA EM 12 MESES -------------------------------------------
pimbr12<-get_sidra(8888,11604,period=c('last'=24),geo='Brazil') %>%
  select('Valor','Mês (Código)','Variável (Código)','Variável',
         'Seções e atividades industriais (CNAE 2.0) (Código)',
         'Seções e atividades industriais (CNAE 2.0)') %>%
  setNames(c('pimbr12','mes','var código','variável','código','atividade')) %>%
  filter(código==129314)

pimgo12<-get_sidra(8888,11604,period=c('last'=24),geo='State') %>%
  select('Valor','Unidade da Federação (Código)','Mês (Código)','Variável (Código)','Variável',
         'Seções e atividades industriais (CNAE 2.0) (Código)',
         'Seções e atividades industriais (CNAE 2.0)') %>%
  setNames(c('pimgo12','UF','mes','var código','variável','código','atividade')) %>%
  filter(código==129314) %>%
  filter(UF==52)

pim12<-pimbr12 %>%
  merge(pimgo12,by='mes') %>%
  select('mes','pimgo12','pimbr12') %>%
  mutate(mes = as.Date(paste0(mes, "01"), format = "%Y%m%d")) %>%
  filter(mes <= floor_date(Sys.Date(), "month") %m-% months(1)) %>%
  # limitando para duas casas decimais
  mutate(pimbr12=round(pimbr12,2),pimgo12=round(pimgo12,2))

last_pim12 <- pim12 %>%
  filter(mes == max(mes))

# DADOS DA PIM MENSAL ----------------------------------------------------------
pimbr<-get_sidra(8888,11601,period=c('last'=24),geo='Brazil') %>%
  select('Valor','Mês (Código)','Variável (Código)','Variável',
         'Seções e atividades industriais (CNAE 2.0) (Código)',
         'Seções e atividades industriais (CNAE 2.0)') %>%
  setNames(c('pimbr','mes','var código','variável','código','atividade')) %>%
  filter(código==129314)

pimgo<-get_sidra(8888,11601,period=c('last'=24),geo='State') %>%
  select('Valor','Unidade da Federação (Código)','Mês (Código)','Variável (Código)','Variável',
         'Seções e atividades industriais (CNAE 2.0) (Código)',
         'Seções e atividades industriais (CNAE 2.0)') %>%
  setNames(c('pimgo','UF','mes','var código','variável','código','atividade')) %>%
  filter(código==129314) %>%
  filter(UF==52)

pim<-pimbr %>%
  merge(pimgo,by='mes') %>%
  select('mes','pimgo','pimbr') %>%
  mutate(mes = as.Date(paste0(mes, "01"), format = "%Y%m%d")) %>%
  filter(mes <= floor_date(Sys.Date(), "month") %m-% months(1)) %>%
  # limitando para duas casas decimais
  mutate(pimbr=round(pimbr,2),pimgo=round(pimgo,2))

last_pim <- pim %>%
  filter(mes == max(mes))

# DADOS DA PMC VARIAÇÃO ACUMULADA EM 12 MESES ----------------------------------
pmcbr12<-get_sidra(8880,11711,period=c('last'=24),geo='Brazil') %>%
  select('Valor','Mês (Código)','Variável','Tipos de índice (Código)','Tipos de índice') %>%
  setNames(c('pmcbr12','mes','variavel','indiceC','indice')) %>%
  filter(indiceC==56734) %>%
  mutate(mes = as.Date(paste0(mes, "01"), format = "%Y%m%d"))

pmcgo12<-get_sidra(8880,11711,period=c('last'=24),geo='State') %>%
  select('Valor','Unidade da Federação (Código)','Mês (Código)',
         'Variável','Tipos de índice (Código)','Tipos de índice') %>%
  setNames(c('pmcgo12','uf','mes','variavel','indiceC','indice')) %>%
  filter(uf==52) %>%
  filter(indiceC==56734) %>%
  mutate(mes = as.Date(paste0(mes, "01"), format = "%Y%m%d"))

pmc12<-pmcbr12 %>%
  merge(pmcgo12,by='mes') %>%
  select('mes','pmcbr12','pmcgo12') %>%
  mutate(pmcbr12=round(pmcbr12,2),pmcgo12=round(pmcgo12,2))

last_pmc12 <- pmc12 %>%
  filter(mes == max(mes))

# PMC VARIAÇÃO MENSAL ----------------------------------------------------------
pmcbr<-get_sidra(8880,11708,period=c('last'=24),geo='Brazil') %>%
  select('Valor','Mês (Código)','Variável','Tipos de índice (Código)','Tipos de índice') %>%
  setNames(c('pmcbr','mes','variavel','indiceC','indice')) %>%
  filter(indiceC==56734) %>%
  mutate(mes = as.Date(paste0(mes, "01"), format = "%Y%m%d"))

pmcgo<-get_sidra(8880,11708,period=c('last'=24),geo='State') %>%
  select('Valor','Unidade da Federação (Código)','Mês (Código)',
         'Variável','Tipos de índice (Código)','Tipos de índice') %>%
  setNames(c('pmcgo','uf','mes','variavel','indiceC','indice')) %>%
  filter(uf==52) %>%
  filter(indiceC==56734) %>%
  mutate(mes = as.Date(paste0(mes, "01"), format = "%Y%m%d"))

pmc<-pmcbr %>%
  merge(pmcgo,by='mes') %>%
  select('mes','pmcbr','pmcgo') %>%
  mutate(pmcbr=round(pmcbr,2),pmcgo=round(pmcgo,2))

last_pmc <- pmc %>%
  filter(mes == max(mes))

# DADOS DA PMS VARIAÇÃO ACUMULADA EM 12 MESES ----------------------------------
pmsbr12<-get_sidra(5906,11626,period=c('last'=24),geo='Brazil') %>%
  select('Valor','Mês (Código)','Variável','Tipos de índice (Código)','Tipos de índice') %>%
  setNames(c('pmsbr12','mes','variavel','indiceC','indice')) %>%
  filter(indiceC==56726) %>%
  mutate(mes = as.Date(paste0(mes, "01"), format = "%Y%m%d"))

pmsgo12<-get_sidra(5906,11626,period=c('last'=24),geo='State') %>%
  select('Valor','Unidade da Federação (Código)','Mês (Código)',
         'Variável','Tipos de índice (Código)','Tipos de índice') %>%
  setNames(c('pmsgo12','uf','mes','variavel','indiceC','indice')) %>%
  filter(uf==52) %>%
  filter(indiceC==56726) %>%
  mutate(mes = as.Date(paste0(mes, "01"), format = "%Y%m%d"))

pms12<-pmsbr12 %>%
  merge(pmsgo12,by='mes') %>%
  select('mes','pmsbr12','pmsgo12') %>%
  mutate(pmsbr12=round(pmsbr12,2),pmsgo12=round(pmsgo12,2))

last_pms12 <- pms12 %>%
  filter(mes == max(mes))

# PMS VARIAÇÃO MENSAL ----------------------------------------------------------
pmsbr<-get_sidra(5906,11623,period=c('last'=24),geo='Brazil') %>%
  select('Valor','Mês (Código)','Variável','Tipos de índice (Código)','Tipos de índice') %>%
  setNames(c('pmsbr','mes','variavel','indiceC','indice')) %>%
  filter(indiceC==56726) %>%
  mutate(mes = as.Date(paste0(mes, "01"), format = "%Y%m%d"))

pmsgo<-get_sidra(5906,11623,period=c('last'=24),geo='State') %>%
  select('Valor','Unidade da Federação (Código)','Mês (Código)',
         'Variável','Tipos de índice (Código)','Tipos de índice') %>%
  setNames(c('pmsgo','uf','mes','variavel','indiceC','indice')) %>%
  filter(uf==52) %>%
  filter(indiceC==56726) %>%
  mutate(mes = as.Date(paste0(mes, "01"), format = "%Y%m%d"))

pms<-pmsbr %>%
  merge(pmsgo,by='mes') %>%
  select('mes','pmsbr','pmsgo') %>%
  mutate(pmsbr=round(pmsbr,2),pmsgo=round(pmsgo,2))

last_pms <- pms %>%
  filter(mes == max(mes))

