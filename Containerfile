ARG FEDORA_MAJOR_VERSION=39
ARG BASE_CONTAINER_URL=ghcr.io/ublue-os/kinoite-nvidia

FROM ${BASE_CONTAINER_URL}:${FEDORA_MAJOR_VERSION}
ARG RECIPE

# copy over configuration files
COPY etc /etc
# COPY usr /usr

COPY ${RECIPE} /tmp/ublue-recipe.yml
COPY ${RECIPE} /etc/recipe.yml
COPY rpm_overlay /tmp/rpm_overlay
COPY rpm_install /tmp/rpm_install

# yq used in build.sh and the setup-flatpaks recipe to read the recipe.yml
# copied from the official container image as it's not avaible as an rpm
COPY --from=docker.io/mikefarah/yq /usr/bin/yq /usr/bin/yq

# copy and run the build script
COPY build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh && /tmp/build.sh

# clean up and finalize container build
RUN rm -rf \
        /tmp/* \
        /var/* && \
    ostree container commit
