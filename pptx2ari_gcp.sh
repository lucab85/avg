#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  stop("Missing input PPTX file file", call.=FALSE)
}

# ENV
#Sys.setenv("GL_AUTH_FILE" = "")

input = args[1]
markdown = paste(input, "md", sep=".")
output = paste(input, "mp4", sep=".")
voice = "en-US-Wavenet-B"
service = "google"
subtitles = TRUE
verbose = TRUE

doc <- ariExtra::pptx_to_ari(
	input,
	dpi = 300,
	output = markdown
)

doc[c("images", "script")]

script = doc$script
slides = doc$images

pptx_result <- ari::ari_spin(slides, script,
	output = output, voice = voice, verbose = verbose, subtitles = subtitles
)
