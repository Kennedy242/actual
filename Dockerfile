###################################################
# This Dockerfile is used by the docker-compose.yml
# file to build the development container.
# Do not make any changes here unless you know what
# you are doing.
###################################################

FROM node:22-bookworm as dev

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y openssl

WORKDIR /app

# Copy dependency manifests first (better layer caching)
COPY package.json yarn.lock .yarnrc.yml ./
COPY .yarn/ .yarn/
COPY packages/ packages/

RUN corepack enable && yarn install

# node image ships with a 'node' user (uid 1000) — just use it
RUN chown -R node:node /app
USER node

CMD ["yarn", "start:browser"]

