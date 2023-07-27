FROM golang:latest AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o appgo ./app/main.go 

FROM scratch AS hello

WORKDIR /app

COPY --from=builder /app/appgo .

ENTRYPOINT [ "./appgo" ]