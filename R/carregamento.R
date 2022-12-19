library(tidyverse)
library(lubridate)

# Estoque_Novo_Caged_Consolidacao_Saldo_202004
df_wide <-
  readRDS("./data/Estoque_Novo_Caged_Consolidacao_Saldo_TRIMESTRE_20221030.RDS")


df_long_cnae <-
  tidyr::pivot_longer(
    df_wide,
    values_to = "estoque",
    names_to = "trimestre",
    cols = c( "2020.1", "2020.2", "2020.3", "2020.4", 
              "2021.1", "2021.2", "2021.3", "2021.4"
    )
  )


colnames(df_long_cnae) <- # posteriormente gerar o Rds sem acentuação
  iconv(colnames(df_long_cnae), from = "UTF-8", to = "ASCII//TRANSLIT")



# Começar com somente Extrativa
df_long_cnae <-
  filter(df_long_cnae, secao == "Indústrias Extrativas")


df_long_cnae$trimestre <- 
  as.factor(df_long_cnae$trimestre)



df_long_cnae <-
  df_long_cnae[, c("subclasse_Cod",
                   "subclasse",
                   "classe",
                   "grupo",
                   "divisao",
                   "secao",
                   "Municipio",
                   "UF_sigla",
                   "trimestre",
                   "estoque")]

# df_long_Subclasse ----
df_long_cnae <- 
  df_long_cnae[df_long_cnae$estoque > 0, ]



# df_long_cnae_Classe ----
df_long_cnae_Classe <- 
  summarise(group_by(df_long_cnae,
                      # subclasse_Cod
                      # ,subclasse
                         classe
                        ,grupo
                        ,divisao
                     # ,secao
                      # ,Municipio
                        ,UF_sigla
                        ,trimestre
                     ), "estoque" = sum(estoque, na.rm = T))

# df_long_cnae_Grupo ----

df_long_cnae_Grupo <- 
  summarise(group_by(df_long_cnae,
                     # subclasse_Cod
                     # ,subclasse
                     # ,classe
                        grupo
                       ,divisao
                     # ,secao
                     # ,Municipio
                       ,UF_sigla
                       ,trimestre
  ), "estoque" = sum(estoque, na.rm = T))



# df_long_cnae_Divisao ----
df_long_cnae_Divisao <- 
  summarise(group_by(df_long_cnae,
                     # subclasse_Cod
                     # ,subclasse
                     # ,classe
                     # ,grupo
                        divisao
                     # ,secao
                     # ,Municipio
                       ,UF_sigla
                       ,trimestre
  ), "estoque" = sum(estoque, na.rm = T))



# _____ Variáveis de sessão ----
UF <-
  c("AC","AL","AM","AP","BA","CE","DF","ES","GO","MA","MG","MS","MT","PA","PB","PE","PI","PR","RJ","RN","RO","RR","RS","SC","SE","SP","TO")

TRIMESTRES <- sort(unique(df_long_cnae$trimestre), ordered = T)
MUNICIPIOS <- "Todos"
