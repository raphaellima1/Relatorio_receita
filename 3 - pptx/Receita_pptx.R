setwd("./../")

# numero de seções
s <- 1
# Nº de graficos
g <- 1
# Nº de tabelas
t <- 1

###############################################
# Capa Slide
###############################################

my <- read_pptx('template.pptx') %>% 
  
  ph_with(value = "Acompanhamento Receitas", 
          location = ph_location_type(type = "ctrTitle")) %>% 
  
  ph_with(value = glue("Ultima atualização - {Sys.Date()}"), 
          location = ph_location_type(type = "subTitle")) 




###############################################
# Receita TOtAL
###############################################
setwd("./3.1- SLIDE - RECEITA TOTAL/")
source( encoding = 'UTF-8', file = '2 - SLIDE.R')
source( encoding = 'UTF-8', file = '2.1 SLIDE.R')

my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "RECEITA TOTAL LÍQUIDA", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Arrecadação total"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Secretaria de Economia do Estado de Goiás", 
          location = ph_location_type(type = "ftr")) %>% 
  
  ph_with(value = empty_content(), 
          location = ph_location_type(type = "sldNum")) %>% 
  #  
  ph_with(tabela_acumulado, 
          location = ph_location(left = 0.5, top = 1.3)) 


# Receita TOtAL - Gráfico
###############################################
my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "RECEITA TOTAL LÍQUIDA", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Arrecadação total"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Secretaria de Economia do Estado de Goiás", 
          location = ph_location_type(type = "ftr")) %>% 
  
  ph_with(value = empty_content(), 
          location = ph_location_type(type = "sldNum")) %>% 
  
  ph_with(dml(code = plot(fig.allg)), 
          location = ph_location(left = 0.6,
                                 top = 1.1,
                                 width = 12,8,
                                 height = 5.9))  






###############################################
# RCL
###############################################
setwd("./3.1- SLIDE - RECEITA TOTAL/")
source( encoding = 'UTF-8', file = '1 - SLIDE.R')
source( encoding = 'UTF-8', file = '1.1 SLIDE.R')

my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Receita Corrente Líquida (RCL)", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Arrecadação total"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Secretaria de Economia do Estado de Goiás", 
          location = ph_location_type(type = "ftr")) %>% 
  
  ph_with(value = empty_content(), 
          location = ph_location_type(type = "sldNum")) %>% 
  #  
  ph_with(tabela_acumulado, 
          location = ph_location(left = 0.5, top = 1.3)) 


# Receita TOtAL - Gráfico
###############################################
my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Receita Corrente Líquida (RCL)", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Arrecadação total"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Secretaria de Economia do Estado de Goiás", 
          location = ph_location_type(type = "ftr")) %>% 
  
  ph_with(value = empty_content(), 
          location = ph_location_type(type = "sldNum")) %>% 
  
  ph_with(dml(code = plot(fig.allg)), 
          location = ph_location(left = 0.6,
                                 top = 1.1,
                                 width = 12,8,
                                 height = 5.9))  



###############################################
# 1.1 - Participação percentual por atividade econômica
setwd("./4- SLIDE/")
source( encoding = 'UTF-8', file = '1 - SLIDE.R')
source( encoding = 'UTF-8', file = '1.1 - SLIDE.R')

###############################################
# carregar a tabela total chamada df



my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Receitas Tributárias", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Arrecadação total"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Secretaria de Economia do Estado de Goiás", 
          location = ph_location_type(type = "ftr")) %>% 
  
  ph_with(value = empty_content(), 
          location = ph_location_type(type = "sldNum")) %>% 
#  
  ph_with(tabela_acumulado, 
          location = ph_location(left = 0.3, top = 1.9)) %>% 
  
  ph_with(dml(code = plot(fig1)), 
          location = ph_location(left =8.1 , top = 1.7, 
                                 width = 5, height = 4))


rm(fig1)

###############################################
# 1.1 - Participação percentual por atividade econômica
setwd("./4- SLIDE/")
source( encoding = 'UTF-8', file = '2 - SLIDE.R')
###############################################
# carregar a tabela total chamada df

my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Receitas Tributárias", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Comparativo em relação ao ano anterior e o projetado"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Secretaria de Economia do Estado de Goiás", 
          location = ph_location_type(type = "ftr")) %>% 
  
  ph_with(value = empty_content(), 
          location = ph_location_type(type = "sldNum")) %>% 
  #  

  ph_with(dml(code = plot(fig.allg)), 
          location = ph_location(left = 0.6,
                                 top = 1.1,
                                 width = 12,8,
                                 height = 5.9)
          )  

rm(fig1, fig2, fig3, fig4, fig.allg)

###############################################
# 1.1 - Participação percentual por atividade econômica
setwd("./4- SLIDE/")
source( encoding = 'UTF-8', file = '3 - SLIDE.R')


###############################################
# carregar a tabela total chamada df



my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Detalhamento das Receitas com ICMS", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Macro-setores estratégicos"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Secretaria de Economia do Estado de Goiás", 
          location = ph_location_type(type = "ftr")) %>% 
  
  ph_with(value = empty_content(), 
          location = ph_location_type(type = "sldNum")) %>% 
  #  
  ph_with(tabela_COM_ICMS, 
          location = ph_location(left = 0.4, top = 1.3)) %>% 
  
  ph_with(dml(code = plot(fig6)), 
          location = ph_location(left = 9,
                                 top = 1.5,
                                 width = 4,
                                 height = 5))

###############################################
# 1.1 - Participação percentual por atividade econômica
setwd("./4- SLIDE/")
source( encoding = 'UTF-8', file = '4 - SLIDE.R')
###############################################
# carregar a tabela total chamada df

my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Receitas com ICMS", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Comparativo em relação ao ano anterior e o projetado"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Secretaria de Economia do Estado de Goiás", 
          location = ph_location_type(type = "ftr")) %>% 
  
  ph_with(value = empty_content(), 
          location = ph_location_type(type = "sldNum")) %>% 
  #  
  
  ph_with(dml(code = plot(fig.allg)), 
          location = ph_location(left = 0.32,
                                 top = 1.1,
                                 width = 12.75,
                                 height = 5.9))


###############################################
# 1.1 - FPE
setwd("./5 - SLIDE - FPE_FUNDEB/")
source( encoding = 'UTF-8', file = '1 - SLIDE.R')
source( encoding = 'UTF-8', file = '1.1 SLIDE.R')

###############################################
# carregar a tabela total chamada df



my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Trnsferências Correntes", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Cota-Parte do FPE"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Secretaria de Economia do Estado de Goiás", 
          location = ph_location_type(type = "ftr")) %>% 
  
  ph_with(value = empty_content(), 
          location = ph_location_type(type = "sldNum")) %>% 
  #  
  ph_with(tabela_acumulado, 
          location = ph_location(left = 0.3, top = 1.2)) %>% 
  
  ph_with(dml(code = plot(fig1)), 
          location = ph_location(left =8.1 , top = 1.7, 
                                 width = 5, height = 4))


rm(fig1, tabela_acumulado)

###############################################
# 1.1 - FUNDEB
setwd("./5 - SLIDE - FPE_FUNDEB/")
source( encoding = 'UTF-8', file = '2 - SLIDE.R')
source( encoding = 'UTF-8', file = '2.1 SLIDE.R')

###############################################
# carregar a tabela total chamada df



my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Trnsferências Correntes", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Transferências do FUNDEB"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Secretaria de Economia do Estado de Goiás", 
          location = ph_location_type(type = "ftr")) %>% 
  
  ph_with(value = empty_content(), 
          location = ph_location_type(type = "sldNum")) %>% 
  #  
  ph_with(tabela_acumulado, 
          location = ph_location(left = 0.3, top = 1.2)) %>% 
  
  ph_with(dml(code = plot(fig1)), 
          location = ph_location(left =8.1 , top = 1.7, 
                                 width = 5, height = 4))


rm(fig1)


##############################################
# Finalização da apresentação
##############################################


# add slide equipe_imagem
my <- my %>% 
  add_slide(layout = "equipe", master = "RRF_template_01")

#rm(tabela_receita, p, g, )
my %>%
  print(target = glue("{Sys.Date()}.pptx"))%>% 
  browseURL()

