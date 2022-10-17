FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN useradd -m steam \
  && apt-get update \ 
  && apt-get install wget -y \
  && dpkg --add-architecture i386 \
  && echo "deb http://archive.ubuntu.com/ubuntu focal main universe" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install gcc-4.9 libc6-i386 lib32gcc-s1 -y
USER steam

WORKDIR /home/steam

ADD --chown=steam:steam https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz /home/steam/

COPY --chown=steam:steam ./csgo/install /home/steam/

RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
  && tar xvf steamcmd_linux.tar.gz

RUN /bin/bash /home/steam/steamcmd.sh +runscript /home/steam/install

COPY --chown=steam:steam entry.sh /home/steam/

# COPY --chown=steam:steam csgo/autoexec.cfg /home/steam/

EXPOSE 27015/udp

CMD ["/home/steam/entry.sh"]