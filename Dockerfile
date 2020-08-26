FROM golang:1.7.3 AS builder

LABEL maintainer="jyyeo@caltech.edu"

RUN mkdir /build
WORKDIR /build
ADD . /build/
RUN go get github.com/gorilla/mux
RUN CGO_ENABLED=0 GOOS=linux go build -o app .

FROM alpine:latest AS production
WORKDIR /root/
COPY --from=builder /build/app .
CMD ["./app"]

