dados <- c('Receita Corrente Líquida','Receita Total','Cenário da Receita')
sumario <- paste(dados, collapse = "\n")
n_sumario <- '1.\n2.\n3.\n'
# Esqueleto das apresentações ---------------------------------------------

espaco <- function(n_espacos, vezes, dado = NULL){
  a <- rep(n_espacos, vezes)
  b <- paste(a, collapse = "")
  c <- paste0(b, dado)
  return(c)
}
# sb <- espaco(n_espacos = '\n', 5, dados[1])


border1 <- fp_par(
  text.align = "right",
  shading.color = "#2d2e2d")
# numero de seções
s <- 1
# Nº de graficos
g <- 1
# Nº de tabelas
t <- 1


# Capa --------------------------------------------------------------------
my <- read_pptx('template - v2.pptx') %>% 
  
  ph_with(value = "Boletim Econômico", 
          location = ph_location_type(type = "ctrTitle")) %>% 
  
  ph_with(value = glue("Edição de {format(Sys.Date(), '%d/%m/%Y')}"), 
          location = ph_location_type(type = "subTitle"))


# Sumário -----------------------------------------------------------------
my <- my %>%
  add_slide(layout = "capa_seção", 
            master = "RRF_template_01") %>% 
  
  ph_with(value = sumario, 
          location = ph_location_type(type = "title")) %>% 
  
  ph_with(value = n_sumario, 
          location = ph_location_type(type = "subTitle"))


# Receita Corrente Líquida RCL --------------------------------------------

my <- my %>%
  add_slide(layout = "capa_seção", 
            master = "RRF_template_01") %>% 
  
  ph_with(value = espaco('\n',0,dados[1]), 
          location = ph_location_type(type = "title")) %>% 
  
  ph_with(value = espaco('\n',0,'1.'), 
          location = ph_location_type(type = "subTitle"))

# Slide PPTX da RCL
source( encoding = 'UTF-8', file = './3 - pptx/RCL.R')


# Receita Total -----------------------------------------------------------
my <- my %>%
  add_slide(layout = "capa_seção", master = "RRF_template_01") %>% 
  ph_with(value = espaco('\n',1,dados[2]), location = ph_location_type(type = "title")) %>% 
  ph_with(value = espaco('\n',vezes = 1,'2.'), location = ph_location_type(type = "subTitle"))

source( encoding = 'UTF-8', file = './3 - pptx/RECEITA TOTAL.R')


# Cenário da Receita ------------------------------------------------------
my <- my %>%
  add_slide(layout = "capa_seção", master = "RRF_template_01") %>%
  ph_with(value = espaco('\n',2,dados[3]), location = ph_location_type(type = "title")) %>%
  ph_with(value = espaco('\n',vezes = 2,'3.'), location = ph_location_type(type = "subTitle"))

source( encoding = 'UTF-8', file = './3 - pptx/CENARIO_RECEITA.R')


# TRANSFERÊNCIAS CORRENTES -----------------------------------------------


# source( encoding = 'UTF-8', file = './3 - pptx/FPE_FUNDEB.R')
# 
# # add capa_seção - Seção 1
# ###############################################
# my <- my %>%
#   add_slide(layout = "capa_seção", master = "RRF_template_01") %>% 
#   ph_with(value = "RECEITAS TRIBUTÁRIAS", location = ph_location_type(type = "title")) %>% 
#   ph_with(value = "1.", location = ph_location_type(type = "subTitle"))
# 
# # RECEITAS TRIBUTÁRIAS
# ###############################################
# source( encoding = 'UTF-8', file = './3 - pptx/RECEITAS TRIBUTARIAS.R')
# 
# # RECEITAS TRIBUTÁRIAS
# ###############################################
# source( encoding = 'UTF-8', file = './3 - pptx/RECEITAS TRIBUTARIAS G.R')
# 
# # RECEITAS TRIBUTÁRIAS
# ###############################################
# source( encoding = 'UTF-8', file = './3 - pptx/MACRO SETORES.R')
# 
# # add capa_seção - Seção 1
# ###############################################
# my <- my %>%
#   add_slide(layout = "capa_seção", master = "RRF_template_01") %>% 
#   ph_with(value = "EXECUÇÃO ORÇAMENTÁRIA", location = ph_location_type(type = "title")) %>% 
#   ph_with(value = "1.", location = ph_location_type(type = "subTitle"))
# 
# 
# # Execução orçamentária ---------------------------------------------------
# source( encoding = 'UTF-8', file = './3 - pptx/EXECUÇÃO ORÇAMENTARIA.R')
# 
# source( encoding = 'UTF-8', file = './3 - pptx/EXECUÇÃO ORÇAMENTARIA_E.R')
# # Despesa Liquidada -------------------------------------------------------
# source( encoding = 'UTF-8', file = './3 - pptx/DESPESA LIQUIDADA.R')
# # Finalização da apresentação
# ##############################################
# 
# 
# # Adicionar capa de seção - Atividade econômica --------------------------------
# my <- my %>%
#   add_slide(layout = "capa_seção", master = "RRF_template_01") %>% 
#   ph_with(value = "CONJUNTURA ECONÔMICA", location = ph_location_type(type = "title")) %>% 
#   ph_with(value = "1.", location = ph_location_type(type = "subTitle"))
# 
# source( encoding = 'UTF-8', file = './3 - pptx/ATIVIDADE ECONOMICA.R')
# 
# # add slide equipe_imagem
# my <- my %>% 
#   add_slide(layout = "equipe", master = "RRF_template_01")

# Tranferências Constitucionais -------------------------------------------


#rm(tabela_receita, p, g, )
my %>%
  print(target = glue("{Sys.Date()}V2.pptx"))%>% 
  browseURL()

