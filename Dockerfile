FROM node:8.2-alpine

ARG STRIDER_TAG=latest
ARG STRIDER_CLI_TAG=latest

ARG STRIDER_DIR=/strider
ENV STRIDER_DIR=$STRIDER_DIR

ARG STRIDER_CLONE_DEST=$STRIDER_DIR/repositories
ENV STRIDER_CLONE_DEST=$STRIDER_CLONE_DEST

ENV PATH="${PATH}:$STRIDER_DIR/node_modules/.bin"
ENV SERVER_NAME="http://localhost:3000"

WORKDIR $STRIDER_DIR
RUN echo && \
  # Get system dependencies, as well as common Strider plugin requirements.
  apk add --no-cache dumb-init git bash openssh-client && \

  # Process build arguments to produce NPM version tags.
  ( [[ "$STRIDER_TAG" != 'latest' ]] && STRIDER_VER="@${STRIDER_TAG}" || STRIDER_VER="" ) && \
  ( [[ "$STRIDER_CLI_TAG" != 'latest' ]] && STRIDER_CLI_VER="@${STRIDER_CLI_TAG}" || STRIDER_CLI_VER="" ) && \

  # Prepare Strider installation directory.
  mkdir -p "$STRIDER_CLONE_DEST" && \
  yarn add \
    --production \
    --no-lockfile \
    --no-cache \
    --no-progress \
    "strider${STRIDER_VER}" "strider-cli${STRIDER_CLI_VER}" && \

  # Clean up
  rm -rf ~/.npm && \
  rm -rf /tmp/* && \
  yarn cache clean && \
echo

VOLUME $STRIDER_CLONE_DEST
COPY main.js /strider/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/usr/bin/dumb-init"]
CMD ["/bin/sh", "/entrypoint.sh"]
