**WARNING**:

* This is a work in progress
* I stopped using this in favor of [google-chrome-ram.sh](https://gist.github.com/458b08b041074ebf6ea053a1a193e3e3)
* I stopped using because when you switch wifi Docker does not connect to the internet anymore, you have to close the container and start again

# Google Chrome and Firefox

Based on [Jess' Dockerfile](https://github.com/jessfraz/dockerfiles/tree/master/chrome/stable).

## Running

```shell
$ wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O chrome.json
$ docker run --rm \
  --security-opt seccomp=$(pwd)/chrome.json \
  --cpuset-cpus 0 \
  --detach=false \
  --device /dev/dri --device /dev/snd \
  --hostname="google-chrome" --name="google-chrome" \
  --memory 4gb --memory-swap 4g \
  --net host \
  -u $(id -u) \
  -v $HOME/.google-chrome-home:$HOME \
  -v $HOME/Downloads:$HOME/Downloads \
  -v /dev/shm:/dev/shm \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /etc/machine-id:/etc/machine-id:ro \
  -v $HOME/.Xauthority:$HOME/.Xauthority \
  -v /usr/share/dbus-1:/usr/share/dbus-1 \
  -v /var/run/dbus:/var/run/dbus \
  -v /var/run/user/$(id -u):/var/run/user/$(id -u) \
  -e HOME \
  -e DISPLAY=unix:0 \
  -e QT_SCALE_FACTOR \
  -e GDK_DPI_SCALE \
  -e GDK_SCALE \
  -e DBUS_SESSION_BUS_ADDRESS \
  -e XAUTHORITY \
  dmitryrck/google-chrome google-chrome-stable
```

## protip: `/dev/shm`

`/dev/shm` is a temporary directory that is entirely in your machine's RAM.  Running your profile in RAM, in theory, is going to be faster. I have not done any benchmark to ensure that.

Change this line:

```
-v $HOME/.google-chrome-home:$HOME \
```

With:

```
-v /dev/shm/google-chrome-home:$HOME \
```

And backup that directory before you shutdown your machine.
