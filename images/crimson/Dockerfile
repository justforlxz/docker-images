FROM debian:bookworm-slim AS builder

RUN apt-get update && apt-get install -y \
    debootstrap \
    debian-archive-keyring \
    gnupg \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create crimson rootfs using debootstrap
RUN mkdir -p /rootfs && \
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

# Mount necessary filesystems and chroot to configure the system
RUN mount --bind /dev /rootfs/dev && \
    mount --bind /proc /rootfs/proc && \
    mount --bind /sys /rootfs/sys && \
    chroot /rootfs /bin/bash -c "
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    echo 'LANG=en_US.UTF-8' > /etc/locale.conf && \
    echo 'LC_ALL=en_US.UTF-8' >> /etc/environment && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    " && \
    umount /rootfs/sys /rootfs/proc /rootfs/dev

# Create a minimal crimson image
FROM scratch

COPY --from=builder /rootfs /

# Set environment variables
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# Set the default command
CMD ["/bin/bash"]
