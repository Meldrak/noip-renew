FROM debian
LABEL maintainer="loblab"

ARG DEBIAN_FRONTED=noninteractive
ARG PYTHON=python3
ARG USER=abc
ENV UID=99
ENV GID=100

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install chromium-chromedriver || \
    apt-get -y install chromium-driver || \
    apt-get -y install chromedriver
RUN apt-get -y install ${PYTHON}-pip
RUN $PYTHON -m pip install selenium
RUN apt-get -y install curl wget

RUN useradd -d $HOME -u $UID -g $GID $USER
USER $USER
WORKDIR $HOME

ADD noip-renew-skd.sh $HOME/noip-renew-skd.sh
RUN	chmod +x $HOME/noip-renew-skd.sh
ADD noip-renew.py $HOME/noip-renew.py
RUN chmod +x $HOME/noip-renew.py
ADD noip-renew.sh $HOME/noip-renew.sh
RUN	chmod +x $HOME/noip-renew.sh
ADD setup.sh $HOME/setup.sh
RUN chmod +x $HOME/setup.sh

CMD ["/sbin/my_init"]
