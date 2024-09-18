# Carregar os pacotes necessários
library(googleway)
library(git2r)

source("pares_od.txt")
source("get_travel_time.R")

set_key(key = "AIzaSyA6NSHW6qdueChY4UY0wMOB6xPI9wnr6Sc")

# Banco de dados vazio

travel_times <- data.frame(timestamp = as.POSIXct(character()), 
                           idRota = factor(),
                           travel_time = numeric(), 
                           stringsAsFactors = FALSE)

# Número de iterações (12 * 5 minutos = 60 min)
num_iteracoes <- 12
#num_iteracoes <- 4

for(i in 1:num_iteracoes){
  timestamp <- Sys.time()
  for (j in 1:length(pares_od)) {
    travel_time <- get_travel_time(pares_od[[j]]$origem, pares_od[[j]]$destino)
    travel_times <- rbind(travel_times, 
                          data.frame(timestamp = timestamp,
                                     idRota = factor(pares_od[[j]]$idRota),
                                     travel_time = travel_time))
  }
  #Sys.sleep(300)  # Esperar 5 minutos (300 segundos)
  Sys.sleep(120)  # Esperar 5 minutos (300 segundos)
}

 
x = as.character(Sys.time())
filename = paste(x,"_df.csv",sep="")
filename = gsub(":","-",filename)
filename = gsub(" ",".",filename)

# Gerar o banco de dados
write.csv(travel_times, filename)


