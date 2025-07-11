FROM mcr.microsoft.com/playwright:v1.52.0-jammy

# Install asdf from precompiled binary
RUN curl -L https://github.com/asdf-vm/asdf/releases/download/v0.18.0/asdf-v0.18.0-linux-amd64.tar.gz \
  | tar -xz -C /usr/local/bin

RUN asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git
RUN asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
