
###############################################
# ATIVIDADE ECONÔMICA
###############################################
source(encoding = 'UTF-8', file = './4- INSUMO/ATIV_ECONOMICA_G.R')

my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Conjuntura econômica",
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Dados do IBGE e do Banco Central, coletados em {format(Sys.Date(),'%d/%m/%Y')}"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>%
  
  ph_with(value = "Boletim Econômico | Secretaria de Estado da Economia",
          location = ph_location_type(type = "ftr")) %>%
  
  ph_with(value = empty_content(),
          location = ph_location_type(type = "sldNum"))%>%
  
  # ph_with(dml(code = plot(fig1)),
  #         location = ph_location(left =8.1 , top = 1.7,
  #                                width = 5, height = 4))%>%
  
  ph_with(dml(code = plot(fig.allg)), 
          location = ph_location(left = 0.9,
                                 top = 1.05,
                                 width = 11.5,
                                 height = 6.15))

my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Conjuntura econômica",
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Dados do IBGE, coletados em {format(Sys.Date(),'%d/%m/%Y')}"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>%
  
  ph_with(value = "Boletim Econômico | Secretaria de Estado da Economia",
          location = ph_location_type(type = "ftr")) %>%
  
  ph_with(value = empty_content(),
          location = ph_location_type(type = "sldNum"))%>%
  
  # ph_with(dml(code = plot(fig1)),
  #         location = ph_location(left =8.1 , top = 1.7,
  #                                width = 5, height = 4))%>%
  
  ph_with(dml(code = plot(fig.allg1)), 
          location = ph_location(left = 0.9,
                                 top = 1.05,
                                 width = 11.5,
                                 height = 6.15))

my <- my %>%
  add_slide(layout = "título_conteúdo", master = "RRF_template_01") %>%
  
  ph_with(value = "Conjuntura econômica",
          location = ph_location_type(type = "title")) %>%
  
  ph_with(value = glue("Dados do IBGE, coletados em {format(Sys.Date(),'%d/%m/%Y')}"),
          location = ph_location_type(type = "subTitle")) %>%
  
  ph_with(value = format(Sys.Date(), "%d/%m/%Y"),
          location = ph_location_type(type = "dt")) %>%
  
  ph_with(value = "Boletim Econômico | Secretaria de Estado da Economia",
          location = ph_location_type(type = "ftr")) %>%
  
  ph_with(value = empty_content(),
          location = ph_location_type(type = "sldNum"))%>%
  
  # ph_with(dml(code = plot(fig1)),
  #         location = ph_location(left =8.1 , top = 1.7,
  #                                width = 5, height = 4))%>%
  
  ph_with(dml(code = plot(fig.allg2)), 
          location = ph_location(left = 0.9,
                                 top = 1.05,
                                 width = 11.5,
                                 height = 6.15))



print('CONJUNTURA ECONÔMICA <- OK')


rm(PIB,start_data,start_data1,ipca,last_ipca,selic,last_selic,
   dolar,euro,cotacao,last_cotacao,desocgo,desocbr,desoc,last_desoc,rendabr,
   rendago,renda,last_renda,pimbr12,pimgo12,pim12,last_pim12,pimbr,pimgo,pim,
   last_pim,pmsbr12,pmsgo12,pms12,last_pms12,pmsbr,pmsgo,pms,last_pms,pimbr,
   pimgo,pim,last_pim,pmcbr12,pmcgo12,pmc12,last_pmc12,pmcbr,pmcgo,pmc,
   last_pmc,fig1,fig2,fig3,fig4,fig5,fig6,fig7,fig8,fig9,fig10,fig11,fig12,
   fig.allg,fig.allg1,fig.allg2)