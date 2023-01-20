FROM rust as builder
RUN rustup toolchain add nightly
RUN rustup default nightly
RUN cargo +nightly install -f cargo-fuzz

ADD . /trybuild
WORKDIR /trybuild/fuzz

RUN cargo fuzz build normalize

# Package Stage
FROM ubuntu:20.04

COPY --from=builder /trybuild/fuzz/target/x86_64-unknown-linux-gnu/release/normalize /
