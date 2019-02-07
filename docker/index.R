# r script to generate index html based on apps
setwd(".")

html <-
      "<html><head>
      <title>Consultr</title>
      </head>
      <body bgcolor='white'>
      <h1>Consultr</h1>
      <hr>
      <pre>
      <ul>"

dirs <- list.dirs("/srv/shiny-server/", full.names = FALSE)[-1]

dir_html <- paste0("<li><a href='", dirs, "'>", dirs, "</a></li>", collapse = "")

html <-
  paste0(
    html,
    dir_html,
    "</ul></pre><hr></body></html>",
    collapse = "")

write(html, file="/srv/shiny-server/index.html")
