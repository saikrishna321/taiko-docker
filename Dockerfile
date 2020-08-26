FROM zenika/alpine-chrome:with-node

ENV TAIKO_SKIP_CHROMIUM_DOWNLOAD=true
ENV TAIKO_BROWSER_PATH=$CHROME_PATH

# set custom npm_prefix because the user is not 'root'
ENV NPM_CONFIG_PREFIX=/home/chrome/.npm-global
ENV PATH="${NPM_CONFIG_PREFIX}/bin:${PATH}"

RUN mkdir -p $NPM_CONFIG_PREFIX &&\
 npm install -g taiko