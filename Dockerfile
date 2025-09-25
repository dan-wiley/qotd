FROM docker.io/golang:latest

# Create app dir and set permissions so any UID can write
WORKDIR /app
COPY . .

RUN go mod init qotd \
 && go get github.com/gorilla/mux \
 && go get github.com/gorilla/handlers \
 && go build -o qotd .

# Ensure binary and app dir are accessible to non-root UID
RUN chmod -R g+rwX /app

# OpenShift will inject a random UID, but you can explicitly drop root
USER 1001

EXPOSE 10000
CMD ["/app/qotd"]
