FROM debian:bookworm-slim AS builder

RUN apt-get update && apt-get install -y \
    debootstrap \
    debian-archive-keyring \
    gnupg \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create crimson rootfs using debootstrap
# Create a symlink for beige since it's not a standard Debian release
RUN ln -s /usr/share/debootstrap/scripts/unstable /usr/share/debootstrap/scripts/beige && \
    mkdir -p /rootfs && \
    debootstrap \
    --arch=amd64 \
    --variant=minbase \
    --include=ca-certificates,apt-transport-https,gnupg,wget \
    --no-check-gpg \
    beige \
    /rootfs \
    https://community-packages.deepin.com/beige/

# Configure the repository
RUN echo "deb https://community-packages.deepin.com/beige/ crimson main commercial community" > /rootfs/etc/apt/sources.list && \
    echo "# deb-src https://community-packages.deepin.com/beige/ crimson main commercial community" >> /rootfs/etc/apt/sources.list

# Create a minimal crimson image
FROM scratch

COPY --from=builder /rootfs /

# Set environment variables
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# Set the default command
CMD ["/bin/bash"]
