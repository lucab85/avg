[![ci](https://github.com/lucab85/avg/actions/workflows/ci.yml/badge.svg)](https://github.com/lucab85/avg/actions/workflows/ci.yml)
# AVG

AVG is a [Docker](https://www.docker.com/) image for
programmatically building educational content.

## Getting Started (Locally)

1.  Install & start[Docker](https://docs.docker.com/install/)
2.  Pull `docker pull lucab85/avg`
3.  Run the container:
~~~
docker run --name="avg" -dit --mount type=bind,source=$(pwd)/share,target=/share --env-file=default.env lucab85/avg
~~~
4.  To access this running container in the Terminal, run
    `docker exec -it "avg" bash` (can also find the `ID` from
    `docker ps`).
5.  Run the `gs2ari.sh` or `pptx2ari.sh` script


## Environment variables

AVG environment variables:

* `AVG_INPUT` = input
* `AVG_OUTPUT` = output filename (default: input + .mp4)
* `AVG_SERVICE` = tts service (default: "amazon", values: "amazon" / "google")
* `AVG_VOICE` = voices (default: "Joey")
* `AVG_DPI` = dpi of images (default "300")
* `AVG_SUBTITLES` = subtitle, output filename (default: "TRUE")
* `AVG_VERBOSE` = (default: "TRUE")

AWS environment variables:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_DEFAULT_REGION`: example: "eu-west-1"

GCP environment variables:

* `GL_AUTH_FILE`: path of service json file
