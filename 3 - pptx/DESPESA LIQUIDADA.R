# Despesa Liquidada -------------------------------------------------------

source(encoding = 'UTF-8', file = './4- INSUMO/DESPESA_LIQUIDA_G.R')


# Receita TOtAL - Tabela
###############################################


my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Despesa Liquidada", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Comparativo anual"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Boletim Econômico | Secretaria de Estado da Economia", 
          location = ph_location_type(type = "ftr")) %>% 
  
  ph_with(value = empty_content(), 
          location = ph_location_type(type = "sldNum")) %>% 
  #  
  ph_with(dml(code = plot(fig.allg)), 
          location = ph_location(left = 0.6,
                                 top = 1.16,
                                 width = 12,8,
                                 height = 5.9))
  


print('DESPESA LIQUIDADA <- OK')