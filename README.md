# AVG

AVG is a [Docker](https://www.docker.com/) image for
programmatically building educational content.

## Getting Started (Locally)

1.  Install [Docker](https://docs.docker.com/install/).
2.  Start Docker.
3.  Pull `docker pull lucab85/avg`
4.  Run the container:
~~~
docker run --name=avg -dit --mount type=bind,source="$(pwd)"/share,target=/share -e AWS_ACCESS_KEY_ID="" -e AWS_SECRET_ACCESS_KEY="" -e AWS_DEFAULT_REGION="" lucab85/avg`
~~~
5.  To access this running container in the Terminal, run
    `docker exec -it "avg" bash` (can also find the `ID` from
    `docker ps`). Then run `su <username>` to then log into that
    account.
