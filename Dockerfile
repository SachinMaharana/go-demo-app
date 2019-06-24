FROM golang:1.12 AS build
ADD . /src
WORKDIR /src
RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o /app


#

FROM scratch 
EXPOSE 8080
ENV DB db
COPY --from=build /app /app
ENTRYPOINT ["/app"]