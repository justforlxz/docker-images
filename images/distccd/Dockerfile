FROM archlinux:latest

LABEL maintainer="justforlxz <lxz@mkacg.com>"
LABEL author="justforlxz <lxz@mkacg.com>"
LABEL description="A distccd image based on ArchLinux that I use for distributed compilation of Treeland"
ENV LANG=en_US.utf8

RUN pacman -Syyu --noconfirm && \
    pacman -S --noconfirm clang distcc btop && \
    pacman -Scc --noconfirm

# Define how to start distccd by default
# (see "man distccd" for more information)
ENTRYPOINT [\
  "distccd", \
  "--daemon", \
  "--no-detach", \
  "--user", "distcc", \
  "--port", "3632", \
  "--stats", \
  "--stats-port", "3633", \
  "--log-stderr", \
  "--listen", "0.0.0.0" \
]

# By default the distcc server will accept clients from everywhere.
# Feel free to run the docker image with different values for the
# following params.
CMD [\
  "--allow", "0.0.0.0/0", \
  "--nice", "5", \
  "--jobs", "5" \
]

# 3632 is the default distccd port
# 3633 is the default distccd port for getting statistics over HTTP
EXPOSE \
  3632/tcp \
  3633/tcp

# We check the health of the container by checking if the statistics
# are served. (See
# https://docs.docker.com/engine/reference/builder/#healthcheck)
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://0.0.0.0:3633/ || exit 1
