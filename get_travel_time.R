# Função para obter o tempo de viagem
get_travel_time <- function(origem, destino) {
  df <- tryCatch({
    google_distance(origins = origem, 
                    destinations = destino, 
                    mode = "driving",
                    departure_time = "now",
                    simplify = TRUE)
  }, error = function(e) {
    print(e)  # Adiciona log de erros
    return(NULL)
  })
  
  print(df)  # Verifica a estrutura da resposta da API
  
  #if (!is.null(df) && nrow(df) > 0 && length(df$rows$elements[[1]]$duration) > 0) {
  if(!is.null(df)) {
    travel_time <- df$rows[[1]][[1]]$duration_in_traffic$value # tempo em segundos
  } else {
    travel_time <- NA
  }
  return(travel_time)
}
