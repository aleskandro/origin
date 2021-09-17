#
# This is an example HTTP server for demonstrating deployments
#
# The standard name for this image is openshift/deployment-example:v2
#

FROM golang:1.16 AS builder

WORKDIR /deployment
COPY ./deployment.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w' -o deployment deployment.go

FROM scratch

COPY --from=builder /deployment/deployment /deployment

EXPOSE 8080
ENV COLOR="#b5d4a8"
ENTRYPOINT ["/deployment", "v2"]
