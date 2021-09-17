FROM golang:1.16 AS builder
ARG PORT=8080
ARG SECOND_PORT=8888
WORKDIR /hello/
COPY ./hello_openshift.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w' -o hello_openshift hello_openshift.go

FROM scratch
ARG PORT
ARG SECOND_PORT
COPY --from=builder  /hello/hello_openshift /hello_openshift
EXPOSE $PORT $SECOND_PORT
USER 1001
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/hello_openshift"]

