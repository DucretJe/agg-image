FROM rust:slim-bookworm@sha256:376e6785918280aa68bef2d8d7b0204b58dfd486f370419023363c6e8cc09ec3 as builder

# GitHub Release (Renovate handled)
ENV AGG_VER v1.7.0
ENV NERDFONTS_VER v3.4.0

# Packages versions (Renovate handled)
# renovate: datasource=repology depName=debian_12/unzip versioning=loose
ENV UNZIP_VER 6.0
# renovate: datasource=repology depName=debian_12/wget versioning=loose
ENV WGET_VER 1.21.3

# Build agg
RUN cargo install --git https://github.com/asciinema/agg --tag ${AGG_VER}

# Install dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
    "wget=${WGET_VER}*" \
    "unzip=${UNZIP_VER}*" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Hack Nerd Font
RUN wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip -O /tmp/Hack.zip && \
    mkdir -p /usr/share/fonts && \
    unzip -q /tmp/Hack.zip -d /usr/share/fonts && \
    rm /tmp/Hack.zip

FROM debian:bookworm-slim@sha256:e899040a73d36e2b36fa33216943539d9957cba8172b858097c2cabcdb20a3e2

COPY --from=builder /usr/local/cargo/bin/agg /usr/local/bin/agg
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Create a non-root user
RUN useradd --create-home --shell /bin/bash agg && \
    chown -R agg:agg "/usr/local/bin/agg" && \
    chmod +x /usr/local/bin/entrypoint.sh && \
    chown -R agg:agg "/usr/local/bin/entrypoint.sh"

COPY --from=builder /usr/share/fonts /home/agg/.local/share/fonts

RUN chown -R agg:agg "/home/agg/.local/share/fonts"

USER agg
HEALTHCHECK NONE
WORKDIR /workdir

ENTRYPOINT ["/usr/bin/bash", "/usr/local/bin/entrypoint.sh"]
