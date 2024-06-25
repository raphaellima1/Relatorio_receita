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
# 1.1 - Participação percentual por atividade econômica
setwd("./4 - TABELA_FLEXTABLE/")
source( encoding = 'UTF-8', file = 'Receita_pptx.R')
###############################################
# carregar a tabela total chamada df



my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Receitas Tributárias", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Arrecadação das receitas tributárias"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Secretaria de Economia do Estado de Goiás", 
          location = ph_location_type(type = "ftr")) 
  
  #ph_with(value = empty_content(), 
  #        location = ph_location_type(type = "sldNum")) %>%
#  
#  ph_with(table_setor, 
#          location = ph_location(left = 0.6, top = 1.4))






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

