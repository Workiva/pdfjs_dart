FROM drydock-prod.workiva.net/workiva/dart_build_image:1
ARG NPM_TOKEN

RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update && apt-get install -y nodejs
RUN node --version
RUN npm --version

WORKDIR /build/
ADD . /build/
RUN pub get

RUN npm install
RUN mkdir /audit/
ARG BUILD_ARTIFACTS_AUDIT=/audit/*

RUN npm ls -s --json --depth=10 > /audit/npm.lock || [ $? -eq 1 ] || exit
FROM scratch
