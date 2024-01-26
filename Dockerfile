FROM alpine:latest AS builder

WORKDIR /

RUN wget https://github.com/zhboner/realm/releases/download/v2.5.2/realm-x86_64-unknown-linux-gnu.tar.gz && tar -xvf /realm-x86_64-unknown-linux-gnu.tar.gz 

FROM zerotier/zerotier:1.12.2
WORKDIR /
COPY --from=builder /realm /usr/bin/realm
RUN chmod +x /usr/bin/realm

COPY ./exec.sh /
RUN chmod 777 /exec.sh

VOLUME [ "/realm.toml" ]
VOLUME [ "/var/lib/zerotier-one" ]

CMD []

ENTRYPOINT ["/exec.sh"]