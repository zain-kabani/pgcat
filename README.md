# PgCat: PostgreSQL Pooler

PostgreSQL pooler and proxy (like PgBouncer) with support for sharding, load balancing, failover and mirroring.

> This is an actively maintained fork of the original [postgresml/pgcat](https://github.com/postgresml/pgcat).

## Features

| **Feature** | **Status** |
|-------------|------------|
| Transaction pooling | Stable |
| Session pooling | Stable |
| Multi-threaded runtime (Tokio) | Stable |
| Read query load balancing | Stable |
| Failover | Stable |
| Admin database (SHOW POOLS, etc.) | Stable |
| Prometheus metrics | Stable |
| SSL/TLS | Stable |
| MD5 & SCRAM-SHA-256 auth | Stable |
| Live config reloading (SIGHUP) | Stable |
| Auth passthrough (auth_query) | Stable |
| Sharding (extended SQL syntax) | Experimental |
| Sharding (query comments/regex) | Experimental |
| Automatic sharding (query parsing) | Experimental |
| Mirroring | Experimental |

## Quick start

```bash
cargo build --release
RUST_LOG=info cargo run --release
```

Or with Docker:

```bash
docker compose up
```

## Configuration

See [CONFIG.md](CONFIG.md) for all available settings.

## Development

```bash
# Build
cargo build

# Run unit tests
cargo test

# Run with debug logging
RUST_LOG=debug cargo run
```

## License

MIT
