pacman::p_load(tidyverse, readxl, lubridate, glue, ggpubr,gridExtra,grid,
               ggthemes,officer, gt, flextable, kableExtra, magrittr,rvg, 
               mschart, janitor,sidrar)

setwd('\\\\sefazarquivos/AEMFPF/DIVERSOS/Relatorio_receita')

# Carregar base

#importaçãp das bases
setwd("./1 - IMPORTAÇÃO/")
source( encoding = 'UTF-8', file = '0 - importação ICMS.R')


setwd("./3 - pptx/")
source( encoding = 'UTF-8', file = 'Receita_pptx.R')