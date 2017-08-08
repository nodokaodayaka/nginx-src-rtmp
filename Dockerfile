FROM docker.io/centos
RUN yum update -y
RUN yum groupinstall -y "Development Tools"
RUN yum -y install pcre-devel zlib-devel openssl-devel unzip wget
WORKDIR /usr/local/src/
RUN wget http://nginx.org/download/nginx-1.12.1.tar.gz
RUN tar xvzf nginx-1.12.1.tar.gz
RUN wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
RUN unzip master.zip
WORKDIR nginx-1.12.1
RUN ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
RUN make
RUN make install

COPY conf/rtmp.conf /usr/local/nginx/conf/
COPY conf/index.html /usr/local/nginx/html/
RUN cat /usr/local/nginx/conf/rtmp.conf >> /usr/local/nginx/conf/nginx.conf
