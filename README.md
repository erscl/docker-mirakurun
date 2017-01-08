# docker-mirakurun

## build script
```
mkdir -p baseimage
cd baseimage
wget https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-root.tar.gz
wget https://cloud-images.ubuntu.com/xenial/current/MD5SUMS
if [ -z "`cat MD5SUMS | grep xenial-server-cloudimg-amd64-root.tar.gz | grep \`md5sum xenial-server-cloudimg-amd64-root.tar.gz | awk '{ print $1 }'\``" ]; then
        echo "checksum error"
        return 1
fi
cat xenial-server-cloudimg-amd64-root.tar.gz | docker import - ubuntu-xenial
cd ../
rm -r baseimage

docker build -t erscl/mirakurun docker-mirakurun
```
## start-up script
```
docker run --restart=always --name mirakurun \
--net=intra_nw --ip=192.168.35.109 \
--cap-add SYS_NICE \
--cap-add SYS_ADMIN \
--cap-add=NET_ADMIN \
--device=/dev/pt3video0:/dev/pt3video0 \
--device=/dev/pt3video1:/dev/pt3video1 \
--device=/dev/pt3video2:/dev/pt3video2 \
--device=/dev/pt3video3:/dev/pt3video3 \
--volume /etc/localtime:/etc/localtime:ro \
--volume /path/to/this/directory/conf:/usr/local/etc/mirakurun \
--volume /path/to/this/directory/db:/usr/local/var/db/mirakurun \
--volume /var/run/pcscd/pcscd.comm:/var/run/pcscd/pcscd.comm \
--detach \
erscl/mirakurun
```
