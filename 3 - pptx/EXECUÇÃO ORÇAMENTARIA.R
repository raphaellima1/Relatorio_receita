###############################################
# RECEITAS TRIBUTÁRIAS
###############################################
source(encoding = 'UTF-8', file = './4- INSUMO/EXECUÇÃO ORÇAMENTÁRIA.R')

my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Receitas Tributárias",
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Arrecadação Bruta"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>%
  
  ph_with(value = "Boletim Econômico | Secretaria de Estado da Economia",
          location = ph_location_type(type = "ftr")) %>%
  
  ph_with(value = empty_content(),
          location = ph_location_type(type = "sldNum")) %>%
  #
  ph_with(external_img('imagem.png', width = 2.78, height = 2.12),
          location = ph_location(left = 0.3, top = 1.9)) %>%
  
  # ph_with(dml(code = plot(fig1)),
  #         location = ph_location(left =8.1 , top = 1.7,
  #                                width = 5, height = 4))%>%
  
  ph_with(block_list(fpar(ftext(glue('(Em R$ milhões)'),
                                prop = fp_text(font.size = 12,
                                               color = "#292929")),
                          fp_p = border1)),
          
          location = ph_location(left = 1.4, top = 1.6,
                                 width = 6.5,
                                 height = 0.3)) 

print('EXECUÇÃO ORÇAMENTÁRIA <- OK')