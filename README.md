
# Intro

This is a dockerized development environment for C/C++.

For any comments/suggestions, please reach out to the author:

thekyria at gmail dot com

# Quick start 

## Build

```bash
docker build -f Dockerfile -t thekyria/theubuntu:latest .
```

## Run

```bash
docker run -it --rm -P --name theubuntu1 --network="bridge" thekyria/theubuntu:latest
```

## Connect

Connect to the container from another machine (e.g. the host) with:

```bash
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null lab@127.0.0.1 -p 49153
```

In the last command, `49153` is the port that the `ssh` server is exposed at in the container. You can see on which host port, the container ssh server port 22 is expose to with `docker port theubuntu1` or `docker ps`. 


## Code

Using the Remote Explorer (extension id: ms-vscode-remote.remote-ssh) in Vs Code you can connect and develop on the container. After connecting, any required/desired additional vscode extension can be installed remotely to the container - vscode understands you are developing remotely and offers you the option of doing so.


# Remarks 

A few comments on this `Dockerfile`.
- `ubuntu` has been arbitrarily chosen a base for this image
- `ARG`s in the beginning of the file can be modified at will to suit your needs.
- `ssh` has been configured to start  upon `docker run`ning the container. This will generate everytime an ephemeral key - through `ssh-keygen -A`. 
- For this reason, re-running the container and trying to connect from the same host will yield ` @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @` unless the options `StrictHostKeyChecking`,  and `UserKnownHostsFile` are used as specified in the command above.
