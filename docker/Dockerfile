FROM rust:slim-bookworm@sha256:73a2dec704f2850337ed65458a631575bc1b36779e6fa21785b03d177e241604 as builder

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

FROM debian:bookworm-slim@sha256:4d9b5b6cf5f643fdf2887eab79f2f916363704184ab270bf4a5c1d65102d03d2

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
