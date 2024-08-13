mes_atualizacao <- Sys.Date() %m-% months(1)
# mes_atualizacao <- Sys.Date()


suppressMessages({

  pacman::p_load(tidyverse, readxl, lubridate, glue, ggpubr,gridExtra,grid,
                 ggthemes,officer, gt, kableExtra, magrittr,rvg, 
                 mschart, janitor,sidrar, lemon,zoo, rlang,flextable, 
                 htmltools,GetBCBData,rbcb,dplyr,ggplot2,tidyverse,zoo,magrittr,
                 ggthemes,scales,parallel,profvis)
  # setwd('C:/Users/rapha/OneDrive/Documentos/Trabalhos em R/Relatorio_receita')

# Importação dos dados ----------------------------------------------------
  source( encoding = 'UTF-8', file = './1 - IMPORTAÇÃO/0 - importação ICMS.R')
  
  source( encoding = 'UTF-8', file = './1 - IMPORTAÇÃO/1 - importação Receita Total.R')
  
  source( encoding = 'UTF-8', file = './1 - IMPORTAÇÃO/2 - Importação Atividade economica.R')
  
# Configurações gerais ----------------------------------------------------
  source( encoding = 'UTF-8', file = './1 - IMPORTAÇÃO/3 - configurações gerais.R')
  
# Rodar o script ----------------------------------------------------------
  source( encoding = 'UTF-8', file = './3 - pptx/0 - geral.R')


})
