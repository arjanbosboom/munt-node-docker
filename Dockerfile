FROM ubuntu:22.04 AS build

ARG BUILD_JOBS=1

RUN apt-get update && apt-get install -y \
    git build-essential libtool autotools-dev automake pkg-config bsdmainutils curl ca-certificates \
    python3 cmake gperf \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
# Temporary source repository:
# We currently clone from the maintainer fork because it contains changes
# that are still pending merge in the official upstream repository.
# Official upstream: https://github.com/muntorg/munt-official
RUN git clone https://github.com/arjanbosboom/munt-official.git munt
WORKDIR /src/munt

RUN ./autogen.sh
RUN cd depends && make NO_QT=1 NO_UPNP=1 -j$(BUILD_JOBS)

RUN mkdir build && cd build && \
    ../configure \
      --prefix=/src/munt/depends/x86_64-pc-linux-gnu \
      --disable-tests \
      --disable-bench \
      --without-gui && \
    make -j$(BUILD_JOBS)

FROM ubuntu:22.04

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

RUN useradd -r -m -d /home/munt munt

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

COPY --from=build /src/munt/build/src/Munt-daemon /usr/local/bin/Munt-daemon
COPY --from=build /src/munt/build/src/Munt-cli /usr/local/bin/Munt-cli

RUN chmod +x /usr/local/bin/Munt-daemon /usr/local/bin/Munt-cli

WORKDIR /home/munt

EXPOSE 9231 9232

CMD ["Munt-daemon", "-datadir=/home/munt/.munt", "-printtoconsole"]