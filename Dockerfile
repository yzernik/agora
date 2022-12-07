FROM rust:1.61.0-buster AS builder

WORKDIR /app

COPY . ./

RUN CARGO_NET_GIT_FETCH_WITH_CLI=true cargo build --release

FROM debian:buster-slim

COPY --from=builder /app/target/release/agora /usr/local/bin/agora

COPY "entrypoint.sh" .
RUN chmod +x entrypoint.sh

CMD ["./entrypoint.sh"]
