
# Intro

This is a dockerized development environment for C/C++.

For any comments/suggestions, please reach out to the author:

thekyria at gmail dot com

# Quick start 

## Build and run

Use `docker compose` to build and run the container in detached mode.

```bash
docker compose up -d
```

The environment of `docker compose` is set up in the `.env` file. 

You can always stop all compose-related containers with:

```bash
docker compose down
```

Use the following to cleanup corresponding images, containers and volumes:

```bash
docker compose rm -fsv
```

### Alternative: Build

Go directly for the docekr command.

```bash
docker build -f Dockerfile -t thekyria/theubuntu:latest .
```

### Alternative: Run

Go directly for the docekr command, in detached mode.

```bash
docker run -itd --rm -p 49153:22 --name theubuntu1 --network="bridge" thekyria/theubuntu:latest
```

## Connect

Connect to the container from another machine (e.g. the host) with:

```bash
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null lab@127.0.0.1 -p 49153
```

In the last command, `49153` is the port that you chose to export your container ssh server (22) port at your host. You can always verify this with `docker port theubuntu1` or `docker ps`. 


## Code

Using the Remote Explorer (extension id: ms-vscode-remote.remote-ssh) in Vs Code you can connect and develop on the container. After connecting, any required/desired additional vscode extension can be installed remotely to the container - vscode understands you are developing remotely and offers you the option of doing so.


# Remarks 

A few comments on this `Dockerfile`.
- `ubuntu` has been arbitrarily chosen a base for this image
- `ARG`s in the beginning of the file can be modified at will to suit your needs.
- `tzdata` is explicitly installed in a non-interactive way before `cmake` - otherwise the corresponding `RUN` step would wait forever for user input.
- `ssh` has been configured to start  upon `docker run`ning the container. This will generate everytime an ephemeral key - through `ssh-keygen -A`. 
- For this reason, re-running the container and trying to connect from the same host will yield ` @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @` unless the options `StrictHostKeyChecking`,  and `UserKnownHostsFile` are used as specified in the command above.
