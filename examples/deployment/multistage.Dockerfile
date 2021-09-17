#
# This is an example HTTP server for demonstrating deployments
#
# The standard name for this image is openshift/deployment-example
#
FROM golang:1.16 AS builder
WORKDIR /deployment
COPY ./deployment.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w' -o deployment deployment.go

FROM scratch

MAINTAINER Clayton Coleman <ccoleman@redhat.com>
COPY --from=builder /deployment/deployment /deployment

EXPOSE 8080
ENV COLOR="#006e9c"
ENTRYPOINT ["/deployment", "v1"]
