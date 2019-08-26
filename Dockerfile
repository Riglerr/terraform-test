#### BUILD IMAGE ####
FROM golang:1.12-alpine as build
ENV CGO_ENABLED 0
RUN apk add git dep

WORKDIR /go/src/app
COPY . .

RUN dep ensure
RUN go build -v
RUN go test

ENTRYPOINT ["./app"]

### PROD IMAGE ###
FROM alpine as prod
WORKDIR /opt/app
COPY --from=build /go/src/app/app .
CMD ["./app"]