#!/usr/bin/env Rscript

#args = commandArgs(trailingOnly=TRUE)
#if (length(args)==0) {
#  stop("Missing input", call.=FALSE)
#}
#input = args[1]

# ENV
#Sys.setenv("AWS_ACCESS_KEY_ID" = "","AWS_SECRET_ACCESS_KEY" = "","AWS_DEFAULT_REGION" = "")

input = Sys.getenv("AVG_INPUT", "input")
markdown = paste(input, "md", sep=".")
output = Sys.getenv("AVG_OUTPUT", paste(input, "mp4", sep="."))
service = Sys.getenv("AVG_SERVICE", "amazon")
voice = Sys.getenv("AVG_VOICE", "Joey")
dpi = Sys.getenv("AVG_DPI", "300")
subtitles = Sys.getenv("AVG_SUBTITLES", "TRUE")
verbose = Sys.getenv("AVG_VERBOSE", "TRUE")

doc <-ariExtra::gs_to_ari(
  input,
  open = FALSE,
  use_knitr = FALSE,
  dpi = dpi,
  output = markdown
)

doc[c("images", "script")]
script = doc$script
slides = doc$images

result <- ari::ari_spin(slides, script,
  output = output,
  service = service,
  voice = voice,
  verbose = verbose,
  subtitles = subtitles
)

unlink(paste(input, "files", sep="_"), recursive=TRUE)
unlink(markdown)
