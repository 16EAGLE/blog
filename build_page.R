# build site
cat("Build site\n")
#options("blogdown.method" = "html")
blogdown::build_site(run_hugo = T, build_rmd = F, local = T)
cat("Serve site\n")
blogdown::serve_site()

# read menu pages
cat("Read config.toml\n")
config <- readLines("config.toml")
menu <- gsub('\"', "", gsub('identifier = \"', "", trimws(config[which(sapply(config, function(x) grepl("menu.main", x), USE.NAMES = F))+1])))
menu <- menu[menu != "blog" & menu != "about"]
files <- paste0(getwd(), "/public/", menu, "/index.html")
if(any(file.exists(files))){

  # fix menu
  cat("Add html tags\n")
  catch <- mapply(x = files, y = menu, function(x, y){
    z <- readLines(x)
    i <- grep(paste0('<a  href="/', y, '">', y, '</a>'), z)
    z[i] <- paste0('<a  class="active" href="/', y, '">', y, '</a>')
    writeLines(z, x)
  })
  
  # about case
  x <- paste0(getwd(), "/public/index.html")
  z <- readLines(x)
  i <- grep(paste0('<a  href="/">about</a>'), z)
  z[i] <- paste0('<a class="active" href="/">about</a>')
  writeLines(z, x)
  
}else{
  stop("Files not found!")
}
# close down
cat("Stop serve\n")
blogdown::stop_server()

