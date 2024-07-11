
# configuração de borda
border1 <- fp_par(
  text.align = "right",
  shading.color = "#2d2e2d")
border2 <- fp_par(
  text.align = "center",
  shading.color = "#2d2e2d")

# configuração de paleta de cor

# tabela 
cor1 <- c('#E5ECF2', # linhas
          "#004782", # cabeçalho
          '#ffffff', # Letra
          '#bf1e2e' # Numero negativo
          )

cor2 <- c('#002E54', # Ano corrente
          '#009e3c', # Ano Anterior
          '#bf1e2e'  # Projeção
          )

# Configuração do Flextable

flex_tab1 <- set_flextable_defaults(
  font.size = 12, font.family = "Calibri",
  font.color = "#333333",
  table.layout = "fixed",
  border.color = "gray",
  padding.top = 3, padding.bottom = 3,
  padding.left = 4, padding.right = 6)

# configuração de borda Flextable
std_border <- fp_border(color = cor1[3], width = 1.1)
