[![ci](https://github.com/lucab85/avg/actions/workflows/ci.yml/badge.svg)](https://github.com/lucab85/avg/actions/workflows/ci.yml)
# AVG

AVG is a [Docker](https://www.docker.com/)-based project for
programmatically building educational content. For example, converting a Google Slides presentation (that contains speaker notes in each slide) to a video file containing a slide show with computer-generated voiceovers of the speaker notes.

## Requirements
This project requires the following items:

1. A locally installed copy [Docker Desktop](https://docs.docker.com/install) (requires a commerical license) and connected to a valid [DockerHub](https://hub.docker.com) account.
2. Access to an [Amazon Web Services](https://aws.amazon.com) account (for the purpose of converting the speaker notes to audio files).
3. A valid [Github](https://github.com) account.
4. A working directory where the project can be built and used (e.g. `~/repos`).

## Installation

Assuming Docker Desktop is installed and running (and connected to your DockerHub account), the only other installation task is to fetch a copy of the `AVG` github repo, as follows:

```
$ cd ~/repos
$ git clone https://github.com/lucab85/avg.git
$ cd avg
```

If you do not have an AWS Access Key and Secret Key, log into your AWS account and generate these from the Security Credentials screen therein.

## Setup

The configuration settings that control how this project behaves are stored in the `default.env` file. Most of the settings therein are pre-configured to help you get started. However, some additional setup steps may be needed, as follows:

###AWS API Keys

Enter your AWS Access & Secret Keys in the AWS environment variables (in `default.env`) below:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_DEFAULT_REGION`: example: "eu-west-1"

###Create Share Folder

You should also create a folder where the input and output files can be stored and ensure that this matches the folder referenced in the `AVG_INPUT` and `AVG_OUTPUT` variables.

```
$ mkdir share
```

You can choose any folder name you ike here, so long as it matches the one referenced in `default.env` and you adjust the `docker` commands below to use the same value.

###Fetch Slides

Finally, place a copy of the slides you wish to convert (in .pptx format) into the `share` folder (or equivalent) above, naming it `input.pptx` (or whatever value you specified in the ​​`AVG_INPUT` variable in `default.env`).


### Fetch AVG Container
Fetch a copy of the `AVG` container image as follows:

```
$ docker pull lucab85/avg
```

You should now be ready to convert your slides to video/audio format.

##Execution

Once all of the setup tasks have been completed, start your container as follows:

```
$ docker run --name="avg" -dit --mount type=bind,source=$(pwd)/share,target=/share --env-file=default.env lucab85/avg
```

Now log into the running container using the Terminal:

```
$ docker exec -it "avg" bash
```

Finally, convert your slides using the desired conversion script (pptx2ari.sh or gs2ari.sh):

```
# pptx2ari.sh
```

Once completed, your video file should be available on your local system in the `share` foler specified earlier, named in accorandance with the `AVG_OUTPUT` variable in `default.env`.

If you need to change any of the settings in the `default.env` file, you should remove the existing container before restarting it with the updated configuration details, as follows:

```
$ docker rm avg
```

## Configuration Settings

For reference, rhe full set of configuration settings in `default.env` (which are aslo available as Environment Variables) are:

*AVG*

* `AVG_INPUT` = input
* `AVG_OUTPUT` = output filename (default: input + .mp4)
* `AVG_SERVICE` = tts service (default: "amazon", values: "amazon" / "google")
* `AVG_VOICE` = voices (default: "Joey")
* `AVG_DPI` = dpi of images (default "300")
* `AVG_SUBTITLES` = subtitle, output filename (default: "TRUE")
* `AVG_VERBOSE` = (default: "TRUE")

*AWS*

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_DEFAULT_REGION`: example: "eu-west-1"

*GCP*

* `GL_AUTH_FILE`: path of service json file