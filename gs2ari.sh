#!/usr/bin/env Rscript

input = Sys.getenv("AVG_INPUT", "input")
markdown = paste(input, "md", sep=".")
output = Sys.getenv("AVG_OUTPUT", paste(input, "mp4", sep="."))
service = Sys.getenv("AVG_SERVICE", "amazon")
voice = Sys.getenv("AVG_VOICE", "Joey")
dpi = as.double(Sys.getenv("AVG_DPI", 300))
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
