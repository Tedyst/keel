FROM golang:1.13.8-alpine
COPY . /go/src/github.com/keel-hq/keel
WORKDIR /go/src/github.com/keel-hq/keel
RUN apk update && apk add make gcc g++ git
RUN make install


FROM alpine:latest
RUN apk --no-cache add ca-certificates

VOLUME /data
ENV XDG_DATA_HOME /data

COPY --from=0 /go/bin/keel /bin/keel
COPY ./ui/dist /www
ENTRYPOINT ["/bin/keel"]
EXPOSE 9300