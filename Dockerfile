FROM fedora:30 AS build_env

RUN dnf update -y && dnf install -y @development-tools xz cmake libcurl-devel zlib-devel libgcrypt-devel gettext-devel gnutls-devel ca-certificates aspell asciidoctor python-devel ncurses-devel
RUN adduser -m weechat

USER weechat
WORKDIR /home/weechat
RUN curl -o weechat-2.4.tar.xz https://weechat.org/files/src/weechat-2.4.tar.xz
RUN tar xf weechat-2.4.tar.xz
RUN mkdir weechat-2.4/build
WORKDIR weechat-2.4/build
RUN cmake -DCMAKE_INSTALL_PREFIX=/opt/weechat ..
RUN make
USER root
RUN make install
USER weechat


FROM golang:1 AS gosu

RUN go get github.com/tianon/gosu


FROM fedora:30

ENV LANG=en_GB.utf8
RUN dnf update -y && dnf install -y libcurl zlib libgcrypt gettext gnutls ca-certificates aspell python ncurses
RUN pip install websocket-client

COPY --from=gosu /go/bin/gosu /bin/gosu
COPY --from=build_env /opt/weechat /opt/weechat
COPY user.sh /root/user.sh

CMD /opt/weechat/bin/weechat
ENTRYPOINT /root/user.sh
