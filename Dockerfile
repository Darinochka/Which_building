FROM rust:1.71.0 as builder

RUN USER=root cargo new --bin which_building
WORKDIR /which_building

COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

RUN cargo build --release
RUN rm src/*.rs

COPY ./src ./src

RUN rm ./target/release/deps/which_building*
RUN cargo install --path .

# our final base
FROM rust:1.71.0

# copy the build artifact from the build stage
COPY --from=builder /which_building/target/release/which_building .

ARG TELOXIDE_TOKEN
ENV TELOXIDE_TOKEN=$TELOXIDE_TOKEN
CMD ["./which_building"]

