parse_explorenz <- function(x){
  
  library(xml2)
  library(dplyr)
  
  d <- xml_find_all(explorenz, "*")
  d1 <- xml_children(d)
  
  d2 = xml_children(d1[[x]])
  size = xml_length(d2)
  
  
  xml2::xml_contents(d2[[1]]) %>% 
    xml_attrs() %>%
    unlist(use.names = FALSE) -> dt_colnames
  
  dt_colnames <- lapply(dt_colnames, function(x) {df <- data.table(col = NA); names(df) <- x; return(df)} )
  dt_colnames <- do.call(cbind, dt_colnames)[-1,]
  
  
  dt_data <- rbindlist(lapply(1:length(size), function(i) {
    as.list(  xml2::xml_contents(d2[[i]]) %>% 
                xml_text() %>%
                unlist(use.names = FALSE) %>%
                t() %>%
                data.table()
    )
  }))
  
  dt_final <- rbindlist(list(dt_colnames, dt_data), use.names = FALSE)
  
  return(dt_final)
  
}
