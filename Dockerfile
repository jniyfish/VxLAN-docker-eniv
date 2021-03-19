FROM ubuntu:18.04

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install vim -y
RUN apt-get install iptables -y
RUN apt-get install iproute2 -y
RUN apt-get install tcpdump -y
RUN apt-get install git -y
RUN apt-get install isc-dhcp-server -y
RUN apt-get install isc-dhcp-client -y
RUN apt-get install iputils-ping -y
RUN apt-get install arping -y
RUN apt-get install tar -y
RUN apt-get install gawk libreadline7 libreadline-dev pkg-config -y

RUN mkdir /c-ares
RUN mkdir /quagga
COPY ./c-ares-1.17.1.tar.gz /c-ares/
RUN tar -xzvf /c-ares/c-ares-1.17.1.tar.gz
RUN /c-ares-1.17.1/configure
RUN cd /c-ares-1.17.1/
RUN make
RUN make install

COPY ./quagga-1.2.4.tar.gz /quagga/
RUN tar -xzvf /quagga/quagga-1.2.4.tar.gz
RUN cd /quagga-1.2.4/
RUN /quagga-1.2.4/configure --enable-vtysh --enable-user=root --enable-group=root --enable-vty-group=root
RUN make
RUN make install

RUN cp /usr/local/lib/libzebra.so.1 /lib
