FROM openjdk:8-jdk-alpine

LABEL maintainer="mba@fourplusone.de"

RUN mkdir /tmp/atlas-sdk && \
    wget --output-document=atlassian-plugin-sdk.tgz https://marketplace.atlassian.com/download/plugins/atlassian-plugin-sdk-tgz && \
    tar -xvzf atlassian-plugin-sdk.tgz -C /tmp/atlas-sdk && \
    rm atlassian-plugin-sdk.tgz &&  \
    mkdir /opt/atlas-sdk && mv /tmp/atlas-sdk/*/* /opt/atlas-sdk
    
ADD atlas-prefetch.sh /usr/bin/atlas-prefetch
RUN chmod +x /usr/bin/atlas-prefetch

ENV PATH /opt/atlas-sdk/bin:$PATH
