# Carregar os pacotes necessários
library(googleway)
library(git2r)

if (!is.null(df) && length(df$rows) > 0 && length(df$rows$elements[[1]]$duration) > 0) {
  travel_time <- df$rows[[1]][[1]]$duration_in_traffic$value # tempo em segundos
} else {
  travel_time <- NA
}
return(travel_time)
}

# Banco de dados vazio

travel_times <- data.frame(timestamp = as.POSIXct(character()), 
                           idRota = factor(),
                           travel_time = numeric(), 
                           stringsAsFactors = FALSE)

#travel_times <- data.frame()

# Número de iterações (12 * 5 minutos = 60 min)
#num_iteracoes <- 12
num_iteracoes <- 2

for (i in 1:num_iteracoes) {
  timestamp <- Sys.time()
  for (par in pares_od) {
    travel_time <- get_travel_time(pares_od[[i]]$origem, pares_od[[i]]$destino)
    travel_times <- rbind(travel_times, 
                          data.frame(timestamp = timestamp,
                                     idRota = factor(pares_od[[i]]$idRota),
                                     travel_time = travel_time))
  }
  Sys.sleep(300)  # Esperar 5 minutos (300 segundos)
}

arquivo <- paste(as.POSIXct(Sys.Date()), "df", sep = "_")

# Gerar o banco de dados
travel_times %>% 
  fwrite(paste(arquivo, ".csv"))



