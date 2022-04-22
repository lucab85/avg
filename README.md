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

### AWS API Keys

Enter your AWS Access & Secret Keys in the AWS environment variables (in `default.env`) below:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_DEFAULT_REGION`: example: "eu-west-1"

### Create Share Folder

You should also create a folder where the input and output files can be stored and ensure that this matches the folder referenced in the `AVG_INPUT` and `AVG_OUTPUT` variables.

```
$ mkdir share
```

You can choose any folder name you ike here, so long as it matches the one referenced in `default.env` and you adjust the `docker` commands below to use the same value.

### Fetch Slides

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
$ docker stop avg
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

## FAQ

### Text to Speech

#### How does the text to speech engine in AVG work?

Depending on which value you specify for the `AVG_SERVICE` variable, the following text-to-speech services will be used:

* [Amazon Polly](https://docs.aws.amazon.com/polly)
* [Google Cloud Text-to-Speech](https://cloud.google.com/text-to-speech)

Each of these services also allows you to listen to sample voices in different languages, most of which are tailored for different geographic regions or accents.

#### How long does the video generation process take?

The time it takes to convert your presentation depends on a number of factors, including:

1. The number of slides are in your presentation (i.e. converting each one to a graphic image and then a video (below)).
2. The amount of text in the speaker notes (per slide), where each must be converted to an audio file and then a video clip (with the slide content) of the same length.
3. The value of the `AVG_VOICE` variable, which controls which voice will be used when converting the speaker notes to audio. Some voices speak more slowly than others and slower voices can result in longer videos.
4. The speed of your local system's CPU (the final step of merging the above audio+video assets together to form the completed video is quite compute-intensive).

Some early experiments show that it could take around 75% of the total length of the final video to complete the full video generation.

### Costs

#### How much does it cost to convert a presentation?

The main costs involved involved in this process are:

1. A once-off cost for a [Docker Desktop Pro](https://www.docker.com/pricing) license ($5 per month or $60 per year).
2. A per-usage cost for the text-to-speech conversion, which is incurred each time a presentation is converted and which is charged by the number of characters in the speaker notes (e.g. $4 per million characters on AWS).