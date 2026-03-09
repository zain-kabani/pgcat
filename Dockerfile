FROM rust:1.88.0-slim-trixie AS builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Cache Rust dependencies separately,
# avoiding rebuilding the layer on every source code change
COPY Cargo.toml Cargo.lock ./
RUN cargo fetch

COPY . .
RUN cargo build --release

################################################################################

FROM debian:trixie-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client && \
    groupadd --system --gid 1001 appgroup && \
    useradd --system --uid 1001 --gid appgroup appuser && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    truncate -s 0 /var/log/*log

WORKDIR /etc/pgcat
RUN chown appuser:appgroup /etc/pgcat

USER appuser

COPY --from=builder --chown=appuser:appgroup /app/target/release/pgcat /usr/bin/pgcat
COPY --from=builder --chown=appuser:appgroup /app/pgcat.toml /etc/pgcat/pgcat.toml

ENV RUST_LOG=info
CMD ["pgcat"]
STOPSIGNAL SIGINT
