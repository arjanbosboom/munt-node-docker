FROM ubuntu:22.04 AS build

RUN apt-get update && apt-get install -y \
    git build-essential libtool autotools-dev automake pkg-config bsdmainutils curl ca-certificates \
    python3 cmake gperf \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

# Official repository of Munt
RUN git clone https://github.com/muntorg/munt-official.git munt

WORKDIR /src/munt

RUN ./autogen.sh
RUN cd depends && make NO_QT=1 NO_UPNP=1 -j$(nproc)

RUN mkdir build && cd build && \
    ../configure \
      --prefix=/src/munt/depends/x86_64-pc-linux-gnu \
      --disable-tests \
      --disable-bench \
      --without-gui && \
    make -j$(nproc)

FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    gosu \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 munt && \
    useradd -u 1000 -g munt -m -d /home/munt munt

COPY --from=build /src/munt/build/src/Munt-daemon /usr/local/bin/Munt-daemon
COPY --from=build /src/munt/build/src/Munt-cli /usr/local/bin/Munt-cli

RUN chmod +x /usr/local/bin/Munt-daemon /usr/local/bin/Munt-cli

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /home/munt

EXPOSE 9231 9232

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["Munt-daemon", "-datadir=/home/munt/.munt", "-printtoconsole"]