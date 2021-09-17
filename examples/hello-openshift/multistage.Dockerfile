FROM golang:1.16 AS builder
ARG SECOND_PORT=8888
ARG PORT=8080
WORKDIR /hello/
COPY ./hello_openshift.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w' -o hello_openshift hello_openshift.go

FROM centos
ARG PORT
ARG SECOND_PORT
COPY --from=builder  /hello/hello_openshift /hello_openshift
EXPOSE $PORT $SECOND_PORT
ENV PORT=$PORT
ENV SECOND_PORT=$SECOND_PORT
USER 1001
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/hello_openshift"]

