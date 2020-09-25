# This image uses the official node base image.
FROM node:12.18.3-buster-slim@sha256:dd6aa3ed10af4374b88f8a6624aeee7522772bb08e8dd5e917ff729d1d3c3a4f
 
# The Taiko installation downloads and installs the chromium required to run the tests. 
# However, we need the chromium dependencies installed in the environment. These days, most # Dockerfiles just install chrome to get the dependencies.
RUN apt-get update \
     && apt-get install -y wget gnupg ca-certificates \
     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
     && apt-get update \
     && apt-get install -y google-chrome-stable

# Add the Taiko browser arguments

WORKDIR /taiko
 
# Create an unprivileged user to run Taiko tests
RUN groupadd -r taiko && useradd -r -g taiko -G audio,video taiko && \
   mkdir -p /home/taiko && \
   chown -R taiko:taiko /home/taiko /taiko
 
USER taiko

# Set a custom npm install location so that taiko, Taiko and dependencies can be 
# installed without root privileges
ENV NPM_CONFIG_PREFIX=/home/taiko/.npm-packages
ENV PATH="${NPM_CONFIG_PREFIX}/bin:${PATH}"