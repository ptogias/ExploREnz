# ExploREnz
Function to parse the XML formatted SQL dump provided by the official ExplorEnz website

Hot to run

```
library(xml2)

# Parse XML
explorenz <- xml2::read_xml("enzyme-data.xml")

# Apply function
res <- pbapply::pblapply(c(2,4,6,8,10,12), function(x) lapply(x, parse_explorenz), file = explorenz)

# List of lists to list of data.tables
# TODO: Do this inside the function
for (i in 1:length(res)) {
  
  res[i] <- unlist(res[i], recursive = FALSE)
  
}

# Write tables in an excel file
openxlsx::write.xlsx(res, "explorenz.xlsx")
```
