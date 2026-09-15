FROM golang:1.27.1-alpine AS base

WORKDIR /app
COPY go.mod go.sum* ./
RUN apk add --no-cache gcc make musl-dev && \
    go mod download
COPY . .

FROM base AS build
RUN make

FROM gcr.io/distroless/static-debian13:nonroot AS runtime

COPY --from=build /app/bin/go-ci-test /go-ci-test
WORKDIR /data
VOLUME ["/data"]

ENTRYPOINT ["/go-ci-test"]
