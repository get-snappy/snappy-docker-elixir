FROM mcr.microsoft.com/playwright:v1.52.0-jammy

# Set default Elixir version
ARG ELIXIR_VERSION=1.18.4

# Set default Erlang version
ARG ERLANG_VERSION=27.0

ARG GO_SNAPPY_VERSION=0.0.26

RUN apt-get update && apt-get install -y \
  curl \
  git \
  build-essential \
  libssl-dev \
  libncurses5-dev \
  unzip

# Install asdf from precompiled binary
RUN curl -L https://github.com/asdf-vm/asdf/releases/download/v0.18.0/asdf-v0.18.0-linux-amd64.tar.gz \
  | tar -xz -C /usr/local/bin

ENV HOME=/root
ENV ASDF_DATA_DIR=$HOME/.asdf
ENV PATH=$ASDF_DATA_DIR/shims:$PATH

RUN asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git
RUN asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git

RUN asdf install erlang $ERLANG_VERSION
RUN asdf install elixir $ELIXIR_VERSION

RUN asdf set -u erlang $ERLANG_VERSION
RUN asdf set -u elixir $ELIXIR_VERSION

RUN wget -qO- https://binaries.get-snappy.com/$GO_SNAPPY_VERSION/go-snappy-$GO_SNAPPY_VERSION.linux-amd64.tar.gz | tar xvz -C /tmp
RUN mv /tmp/go-snappy-$GO_SNAPPY_VERSION.linux-amd64/go-snappy /usr/local/bin/go-snappy
RUN rm -rf /tmp/go-snappy-$GO_SNAPPY_VERSION.linux-amd64

RUN mix local.hex --force
RUN mix local.rebar --force

WORKDIR /app