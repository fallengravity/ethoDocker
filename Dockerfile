# Build Geth in a stock Go builder container
FROM golang:1.13-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git

WORKDIR /
RUN git clone --depth 1 https://github.com/Ether1Project/Ether1.git && \
    cd /Ether1 && make && \
    cp -a /Ether1/build/bin/geth /usr/local/bin/ && \
    cd / && rm -rf /Ether1

# Pull Geth into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /usr/local/bin/geth /usr/local/bin/geth-ether1

EXPOSE 30305 30305/udp 8545 8545/udp
ENTRYPOINT ["geth-ether1"]
CMD ["--syncmode=fast", "--cache=512", "--rpc", "--rpcaddr 0.0.0.0"]
