FROM rust:1.71.0 as builder

RUN USER=root cargo new --bin which_building
WORKDIR /which_building

COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

RUN rm src/*.rs
COPY ./src ./src

RUN cargo build --release

FROM rust:1.71.0

COPY --from=builder /which_building/target/release/which_building .

CMD ["./which_building"]

