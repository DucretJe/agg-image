FROM rust:slim-bookworm@sha256:304e30dc3cdb0ac27a39ea4660cc813e5a4c0ff40ae13d8a072835826205cd0c as builder

# GitHub Release (Renovate handled)
ENV AGG_VER v1.4.3
ENV NERDFONTS_VER v3.1.1

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

FROM debian:bookworm-slim@sha256:7802002798b0e351323ed2357ae6dc5a8c4d0a05a57e7f4d8f97136151d3d603

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
