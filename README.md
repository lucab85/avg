# AVG

AVG is a [Docker](https://www.docker.com/) image for
programmatically building educational content.

## Getting Started (Locally)

1.  Install [Docker](https://docs.docker.com/install/).
2.  Start Docker.
3.  Run `docker pull lucab85/avg`
4.  **CHANGE PASSWORD HERE** To start the RStudio server `docker run
    --name=rstudiocon -e USER=${username} -e PASSWORD=<password>
    -dp 8787:8787 -e ROOT=TRUE lucab85/avg`. You may also do `-e 
    ROOT=TRUE`, but you still should have USER/PASSWORD.  
5.  (optional) To access this running container in the Terminal, run
    `docker exec -it "rstudiocon" bash` (can also find the `ID` from
    `docker ps`). Then run `su <username>` to then log into that
    account.
6.  Navigate to <http://localhost:8787/> in your web browser.
