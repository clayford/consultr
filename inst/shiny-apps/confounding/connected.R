# from https://stackoverflow.com/questions/5076593/how-to-determine-if-you-have-an-internet-connection-in-r
library(curl)

connected <- function(){
  !is.null(nslookup("r-project.org", error = FALSE))
}