FROM ubuntu-xenial
MAINTAINER erscl

RUN apt-get update &&\
apt-get upgrade -yV &&\
apt-get -y install git-core curl wget unzip &&\
curl -sL https://deb.nodesource.com/setup_6.x | bash - &&\
apt-get install -y nodejs &&\
apt-get install -y make gcc g++ gzip autoconf automake libc-dev pkg-config libpcsclite-dev &&\
npm install pm2 -g &&\
npm install mirakurun -g --unsafe --production &&\
npm install arib-b25-stream-test -g --unsafe &&\
apt-get -y install pcsc-tools&&\
cd /tmp &&\
wget http://hg.honeyplanet.jp/pt1/archive/c44e16dbb0e2.zip &&\
unzip c44e16dbb0e2.zip &&\
cd pt1-c44e16dbb0e2/arib25 &&\
make clean && make &&\
make install &&\
git clone https://github.com/stz2012/recpt1 /tmp/recpt1 &&\
cd /tmp/recpt1/recpt1 &&\
./autogen.sh &&\
./configure --enable-b25 &&\
make &&\
make install

RUN apt-get update &&\
apt-get install -y ufw

COPY services.sh /usr/local/bin

CMD ["/bin/bash","/usr/local/bin/services.sh"]

EXPOSE 40772

