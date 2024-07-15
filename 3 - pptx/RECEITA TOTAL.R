###############################################
# RCL
###############################################


source(encoding = 'UTF-8', file = './4- INSUMO/RECEITA_TOTAL_T.R')
source(encoding = 'UTF-8', file = './4- INSUMO/RECEITA_TOTAL_G.R')

# Receita TOtAL - Gráfico
###############################################
my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Receita Total Líquida", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Comparativo em relação ao ano anterior e o projetado"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Boletim Econômico | Secretaria de Estado da Economia", 
          location = ph_location_type(type = "ftr")) %>% 
  
  ph_with(value = empty_content(), 
          location = ph_location_type(type = "sldNum")) %>% 
  
  ph_with(dml(code = plot(fig.allg)), 
          location = ph_location(left = 0.6,
                                 top = 2.3,
                                 width = 12,8,
                                 height = 4.9)) %>%
  
  ph_with(block_list(
    fpar(
      ftext(glue('R$ {format(bloco1, decimal.mark = ",", scientific = FALSE)} bi'), 
            prop = fp_text(font.size = 18, color = "#ffffff", bold = T)),
      fp_p = border2
    ),
    fpar(
      ftext(glue('Realizado até jun/24'), 
            prop = fp_text(font.size = 16, color = "#ffffff")),
      fp_p = border2
    ),
    fpar(
      ftext(glue('(Acum. jan/24 a jun/24)'), 
            prop = fp_text(font.size = 10.5, color = "#ffffff")),
      fp_p = border2
    )
  ),
  location = ph_location(left = 0.2, top = 1.1, width = 3.14, 
                         height = 0.90, bg = cor1[2])) |> 
  
  # segundo bloco
  ph_with(block_list(
    fpar(
      ftext(glue('R$ {format(bloco2, decimal.mark = ",", scientific = FALSE)} bi'), 
            prop = fp_text(font.size = 18, color = "#ffffff", bold = T)),
      fp_p = border2
    ),
    fpar(
      ftext(glue('Projetado até jun/24'), 
            prop = fp_text(font.size = 16, color = "#ffffff")),
      fp_p = border2
    ),
    fpar(
      ftext(glue('(Acum. jan/24 a jun/24)'), 
            prop = fp_text(font.size = 10.5, color = "#ffffff")),
      fp_p = border2
    )
  ),
  location = ph_location(left = 3.44, top = 1.1, width = 3.14, 
                         height = 0.90, bg = cor1[2])) |> 
  
  # terceiro bloco
  ph_with(block_list(
    fpar(
      ftext(ifelse(bloco3 > 0, 
                   glue('+ R$ {format(bloco3, decimal.mark = ",", scientific = FALSE)} bi'), 
                   glue('- R$ {format(bloco3, decimal.mark = ",", scientific = FALSE)} bi')), 
            prop = fp_text(font.size = 18, color = "#ffffff", bold = T)),
      fp_p = border2
    ),
    fpar(
      ftext(glue('Realizado x Projetado'), 
            prop = fp_text(font.size = 16, color = "#ffffff")),
      fp_p = border2
    )
  ),
  location = ph_location(left = 6.68, top = 1.1, width = 3.14, 
                         height = 0.90, bg = cor1[2])) |> 
  
  # quarto bloco
  ph_with(block_list(
    fpar(
      ftext(glue('R$ {format(bloco4, decimal.mark = ",", scientific = FALSE)} bi'), 
            prop = fp_text(font.size = 18, color = "#ffffff", bold = T)),
      fp_p = border2
    ),
    fpar(
      ftext(glue('Previsão acum. para Dez/24'), 
            prop = fp_text(font.size = 16, color = "#ffffff")),
      fp_p = border2
    )
  ),
  location = ph_location(left = 9.92, top = 1.1, width = 3.14, 
                         height = 0.90, bg = cor1[2]))
  
  
  
  
  

# Receita TOtAL Tabela
###############################################

my <- my %>%
  add_slide(layout = "título_conteúdo_nota", master = "RRF_template_01") %>%
  
  ph_with(value = "Receita Total Líquida", 
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Comparativo mensal*"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>% 
  
  ph_with(value = "Boletim Econômico | Secretaria de Estado da Economia", 
          location = ph_location_type(type = "ftr")) %>% 
  
  ph_with(value = empty_content(), 
          location = ph_location_type(type = "sldNum")) %>% 
  #  
  ph_with(tabela_acumulado, 
          location = ph_location(left = 1.35, top = 1.3)) %>% 
  
  ph_with(block_list(fpar(ftext(glue('(Em R$ milhões)'), 
                                prop = fp_text(font.size = 12, 
                                               color = "#292929")), 
                          fp_p = border1)),
          
          location = ph_location(left = 5.5, top = 1.0, 
                                 width = 6.5,
                                 height = 0.3)) %>% 
  
  ph_with(block_list(fpar(ftext(glue('* Resultados preliminares'),
                                prop = fp_text(font.size = 11,
                                               color = "#292929")))),
          
          location = ph_location(left = 0, top = 0.88,
                                 width = 2,
                                 height = 0.201))

print('RTL <- OK')