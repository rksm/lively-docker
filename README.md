# Docker setup for [Lively Web](https://github.com/LivelyKernel/LivelyKernel)

## Important
Make sure objects.sqlite is existant`touch objects.sqlite` !!!

Later, when lively started up you can get a "real" copy of the objects DB via
`curl localhost:9001/objects.sqlite > objects.sqlite` and rebuild the server to
have a shorter startup time.

## Build and run
The docker image is build and run via

```sh
docker build --rm -t lively-server .
docker run -p 9011:9001 -i -t lively-server
```

### Mac OS hint

If you run docker via [boot2docker](https://github.com/boot2docker/boot2docker)
then make sure you not only forward ports between the lively-server and the
boot2docker environment but also between boot2docker and Mac OS:

```sh
VBoxManage controlvm boot2docker-vm natpf1 "lively-server,tcp,127.0.0.1,9011,,9011"
```
