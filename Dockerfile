# Rust as the base image
FROM rust:1.71.0

# 1. Create a new empty shell project
RUN USER=root cargo new --bin which_building
WORKDIR /which_building

# 2. Copy our manifests
COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

# 3. Build only the dependencies to cache them
RUN cargo build --release
RUN rm src/*.rs

# 4. Now that the dependency is built, copy your source code
COPY ./src ./src

# 5. Build for release.
RUN rm ./target/release/deps/which_building*
RUN cargo install --path .

ARG TELOXIDE_TOKEN
ENV TELOXIDE_TOKEN=$TELOXIDE_TOKEN
CMD ["which_building"]

