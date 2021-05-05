FROM rocker/r-base:latest

COPY pptx2ari_aws.sh /usr/local/bin

COPY pptx2ari_gcp.sh /usr/local/bin

RUN apt-get update \
  && apt-get install -y \
       libpoppler-cpp-dev \
       ffmpeg \
       libavfilter-dev \
       libtesseract-dev \
       libleptonica-dev \
       tesseract-ocr-eng \
       libwebp-dev \
       libgdal-dev \
       imagemagick \
       r-cran-httr \
       libssl-dev \
       libmagick++-dev \
       libfontconfig-dev \
       libxml2-dev \
       libsodium-dev \
       cargo \
       libreoffice && \
       rm -rf /var/lib/apt/lists/*

RUN install2.r --error --deps TRUE \
       magick googledrive tuber pdftools aws.polly usethis docxtractr

RUN installGithub.r --deps TRUE \
       jhudsl/ariExtra jhudsl/ari jhudsl/text2speech jhudsl/didactr
