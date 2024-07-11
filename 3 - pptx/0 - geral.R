border1 <- fp_par(
  text.align = "right",
  shading.color = "#2d2e2d")
# numero de seções
s <- 1
# Nº de graficos
g <- 1
# Nº de tabelas
t <- 1

###############################################
# Capa Slide
###############################################

my <- read_pptx('template - v2.pptx') %>% 
  
  ph_with(value = "Boletim Econômico", 
          location = ph_location_type(type = "ctrTitle")) %>% 
  
  ph_with(value = glue("Edição de {format(Sys.Date(), '%d/%m/%Y')}"), 
          location = ph_location_type(type = "subTitle"))


###############################################
# add capa_seção - Seção 1
###############################################
my <- my %>%
  add_slide(layout = "capa_seção", master = "RRF_template_01") %>% 
  ph_with(value = "RECEITA CORRENTE LIQUÍDA", location = ph_location_type(type = "title")) %>% 
  ph_with(value = "1.", location = ph_location_type(type = "subTitle"))

# RECEITA CORRENTE LIQUIDA - RCL
###############################################
source( encoding = 'UTF-8', file = './3 - pptx/RCL.R')


##############################################
# Finalização da apresentação
##############################################


# add slide equipe_imagem
my <- my %>% 
  add_slide(layout = "equipe", master = "RRF_template_01")

#rm(tabela_receita, p, g, )
my %>%
  print(target = glue("{Sys.Date()}V2.pptx"))%>% 
  browseURL()
