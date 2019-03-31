# lightning-testnet-box docker image

FROM ubuntu:16.04

# install bitcoind (from PPA) and make
RUN apt-get update && \
	apt-get install --yes software-properties-common && \
	add-apt-repository --yes ppa:bitcoin/bitcoin && \
	apt-get update && \
	apt-get install --yes bitcoind make

RUN apt-get install -y \
	autoconf automake build-essential git libtool libgmp-dev \
	libsqlite3-dev net-tools libsodium-dev zlib1g-dev python python3 vim

WORKDIR /root

# clone and compile lightning
RUN git clone https://github.com/ElementsProject/lightning.git

WORKDIR /root/lightning

RUN ./configure && make -j4
RUN make install

# copy the lightning-testnet-box files into the image
ADD . /root/lightning-testnet-box

# color 
RUN mv /root/lightning-testnet-box/.bashrc /root/ && \
	cat /root/.bashrc >> /etc/bash.bashrc

# use root
USER root

# set working dir
WORKDIR /root/lightning-testnet-box

# expose rpc ports for the nodes to allow outside container access
EXPOSE 19001 19011 19021 19031
CMD ["/bin/bash"]
