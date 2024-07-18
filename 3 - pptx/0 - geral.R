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

# rcl
###############################################
my <- my %>%
  add_slide(layout = "capa_seção", master = "RRF_template_01") %>% 
  ph_with(value = "RECEITA CORRENTE LÍQUIDA", location = ph_location_type(type = "title")) %>% 
  ph_with(value = "1.", location = ph_location_type(type = "subTitle"))

# RECEITA CORRENTE LIQUIDA - RCL
###############################################
source( encoding = 'UTF-8', file = './3 - pptx/RCL.R')

###############################################
# add capa_seção - Seção 1
###############################################
my <- my %>%
  add_slide(layout = "capa_seção", master = "RRF_template_01") %>% 
  ph_with(value = "RECEITA TOTAL LÍQUIDA", location = ph_location_type(type = "title")) %>% 
  ph_with(value = "1.", location = ph_location_type(type = "subTitle"))

# RECEITA TOTAL
###############################################
source( encoding = 'UTF-8', file = './3 - pptx/RECEITA TOTAL.R')


# Cenário receita
###############################################
source( encoding = 'UTF-8', file = './3 - pptx/CENARIO_RECEITA.R')

# add capa_seção - Seção 1
###############################################
my <- my %>%
  add_slide(layout = "capa_seção", master = "RRF_template_01") %>% 
  ph_with(value = "TRANSFERÊNCIAS CORRENTES", location = ph_location_type(type = "title")) %>% 
  ph_with(value = "1.", location = ph_location_type(type = "subTitle"))


# FPE e FUNDEB
###############################################
source( encoding = 'UTF-8', file = './3 - pptx/FPE_FUNDEB.R')

# add capa_seção - Seção 1
###############################################
my <- my %>%
  add_slide(layout = "capa_seção", master = "RRF_template_01") %>% 
  ph_with(value = "RECEITAS TRIBUTÁRIAS", location = ph_location_type(type = "title")) %>% 
  ph_with(value = "1.", location = ph_location_type(type = "subTitle"))

# RECEITAS TRIBUTÁRIAS
###############################################
source( encoding = 'UTF-8', file = './3 - pptx/RECEITAS TRIBUTARIAS.R')

# RECEITAS TRIBUTÁRIAS
###############################################
source( encoding = 'UTF-8', file = './3 - pptx/RECEITAS TRIBUTARIAS G.R')

# RECEITAS TRIBUTÁRIAS
###############################################
source( encoding = 'UTF-8', file = './3 - pptx/MACRO SETORES.R')

# add capa_seção - Seção 1
###############################################
my <- my %>%
  add_slide(layout = "capa_seção", master = "RRF_template_01") %>% 
  ph_with(value = "DESPESA", location = ph_location_type(type = "title")) %>% 
  ph_with(value = "1.", location = ph_location_type(type = "subTitle"))


# Despesa -----------------------------------------------------------------
source( encoding = 'UTF-8', file = './3 - pptx/MACRO SETORES.R')


# Finalização da apresentação
##############################################


# add slide equipe_imagem
my <- my %>% 
  add_slide(layout = "equipe", master = "RRF_template_01")

#rm(tabela_receita, p, g, )
my %>%
  print(target = glue("{Sys.Date()}V2.pptx"))%>% 
  browseURL()
