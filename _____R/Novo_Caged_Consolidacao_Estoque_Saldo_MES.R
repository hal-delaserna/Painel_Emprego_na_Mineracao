# rm(list = ls())
options(editor = 'notepad')
library(tidyverse)
library(lubridate)

source("./R_Script/CNAE.R")
source("./R_Script/geocod.R")


# ____________________________________________________________________________________


# Estoque de Trabalhadores secoes_CNAE_B_C ----
estoque_trabalhadores <-
  readRDS(file = "./data/Novo_Caged_estoque_trabalhadores_secoes_CNAE23_B_C_202204.RDS")

estoque_trabalhadores$cnae20subclas <-
  as.integer(estoque_trabalhadores$cnae20subclas)

 estoque_trabalhadores$mes <- NA
 estoque_trabalhadores[estoque_trabalhadores$data == "2020.01.01", ]$mes <-
   2020.00
 estoque_trabalhadores[estoque_trabalhadores$data == "2021.01.01", ]$mes <-
   2021.00
 estoque_trabalhadores[estoque_trabalhadores$data == "2022.01.01", ]$mes <-
   2022.00

# Movimentação de Trabalhadores secoes_CNAE_B_C ----
movimentacao_CNAE_B_C <-
  readRDS(
    file = "./data/Novo_Caged_microdados_movimentacao_secoes_CNAE23_B_C_202207_EXTENDIDO.RDS")

movimentacao_CNAE_B_C$mes <- 
  (movimentacao_CNAE_B_C$competênciamov/100)


# ESTOQUE ----
ESTOQUE <-
  summarise(
    group_by(estoque_trabalhadores,
             mes, 
             codmun, 
             cnae20subclas),
    "valor" = sum(estoqueref)
  )

# ESTOQUE$ano <- ESTOQUE$trimestre
rm(estoque_trabalhadores)

# MOVIMENTACAO ----

MOVIMENTACAO <-
  summarise(
    group_by(movimentacao_CNAE_B_C,
             mes, 
             município, 
             subclasse),
    "valor" = sum(saldomovimentação)
  )

# MOVIMENTACAO$ano <- as.integer(str_extract(MOVIMENTACAO$trimestre, pattern = "^...."))
rm(movimentacao_CNAE_B_C)


# unindo Estoque-Movimentação ----
colnames(MOVIMENTACAO) <- colnames(ESTOQUE)

ESTOQUE <-
  rbind(ESTOQUE, MOVIMENTACAO)
rm(MOVIMENTACAO)

# Long to Wide

ESTOQUE$mes <- as.character(ESTOQUE$mes)

ESTOQUE <-
  pivot_wider(
    data = ESTOQUE,
    names_from = mes,
    values_from = valor,
    values_fill = 0
  )


ESTOQUE$soma <- 
  (ESTOQUE$`2020` + ESTOQUE$`2020.01` + ESTOQUE$`2020.02` + ESTOQUE$`2020.03` + ESTOQUE$`2020.04` + ESTOQUE$`2020.05` + ESTOQUE$`2020.06` + ESTOQUE$`2020.07` + ESTOQUE$`2020.08` + ESTOQUE$`2020.09` + ESTOQUE$`2020.1` + ESTOQUE$`2020.11` + ESTOQUE$`2020.12` +
   ESTOQUE$`2021` + ESTOQUE$`2021.01` + ESTOQUE$`2021.02` + ESTOQUE$`2021.03` + ESTOQUE$`2021.04` + ESTOQUE$`2021.05` + ESTOQUE$`2021.06` + ESTOQUE$`2021.07` + ESTOQUE$`2021.08` + ESTOQUE$`2021.09` + ESTOQUE$`2021.1` + ESTOQUE$`2021.11` + ESTOQUE$`2021.12` +
   ESTOQUE$`2022` + ESTOQUE$`2022.01`)

# ESTOQUE <- ESTOQUE[ESTOQUE$soma > 0,]

colnames(ESTOQUE) <- c("codmun", 
                       "cnae20subclas", "2020.01.01", "2021.01.01", "2022.01.01", "2020.01", 
                       "2020.02", "2020.03", "2020.04", "2020.05", "2020.06", "2020.07", 
                       "2020.08", "2020.09", "2020.10", "2020.11", "2020.12", "2021.01", 
                       "2021.02", "2021.03", "2021.04", "2021.05", "2021.06", "2021.07", 
                       "2021.08", "2021.09", "2021.10", "2021.11", "2021.12", "2022.01", 
                       "soma")

ESTOQUE <- ESTOQUE[,c("codmun", 
                      "cnae20subclas", 
                     "2020.01.01", "2020.01", "2020.02", "2020.03", "2020.04", "2020.05", "2020.06", "2020.07", "2020.08", "2020.09", "2020.10", "2020.11", "2020.12", 
                     "2021.01.01", "2021.01", "2021.02", "2021.03", "2021.04", "2021.05", "2021.06", "2021.07", "2021.08", "2021.09", "2021.10", "2021.11", "2021.12", 
                     "2022.01.01", "2022.01")]


# Ciclo de consolidação de estoques trimestrais
       for (j in c(4:15, 17:28)) {
     # for (j in c(3:14, 16:27)) {
          ESTOQUE[,j] <-
          ESTOQUE[,j - 1] + ESTOQUE[,j]
      }

CNAE_Subclasses_2_0$subclasse <- 
  as.integer(CNAE_Subclasses_2_0$subclasse)

ESTOQUE <- 
   left_join(
    left_join(
      ESTOQUE, 
      CNAE_Subclasses_2_0[,c("subclasse", "subclasse.descrição", "classe", "classe.descrição", 
                             "grupo", "grupo.descrição", "divisão", "divisão.descrição", "seção", 
                             "seção.descrição")], 
      by = c('cnae20subclas' = "subclasse")), 
     geocod[,c("GEOCOD_6", "Município", "UF_sigla")], 
     by = c("codmun" = "GEOCOD_6"))

    

ESTOQUE <- 
  ESTOQUE[,c('cnae20subclas', "2020.01.01", "2020.01", "2020.02", 
             "2020.03", "2020.04", "2020.05", "2020.06", "2020.07", "2020.08", 
             "2020.09", "2020.10", "2020.11", "2020.12", "2021.01.01", "2021.01", 
             "2021.02", "2021.03", "2021.04", "2021.05", "2021.06", "2021.07", 
             "2021.08", "2021.09", "2021.10", "2021.11", "2021.12", "2022.01.01", 
             "2022.01", "subclasse.descrição", "classe.descrição", "grupo.descrição", 
             "divisão.descrição", "seção.descrição", 
              "Município", "UF_sigla"
             )]

colnames(ESTOQUE) <- c("subclasse_Cod", "2020.01.01", "2020.01", "2020.02", 
                       "2020.03", "2020.04", "2020.05", "2020.06", "2020.07", "2020.08", 
                       "2020.09", "2020.10", "2020.11", "2020.12", "2021.01.01", "2021.01", 
                       "2021.02", "2021.03", "2021.04", "2021.05", "2021.06", "2021.07", 
                       "2021.08", "2021.09", "2021.10", "2021.11", "2021.12", "2022.01.01", 
                       "2022.01", "subclasse", "classe", "grupo", "divisão", "seção", 
                       "Município", "UF_sigla"
                       )

saveRDS(ESTOQUE, "./data/Estoque_Novo_Caged_Consolidacao_Saldo_20220926.RDS")



