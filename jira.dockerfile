FROM openjdk:8-jdk-alpine

LABEL maintainer="mba@fourplusone.de"

RUN mkdir /tmp/atlas-sdk && \
    wget --output-document=atlassian-plugin-sdk.tgz https://marketplace.atlassian.com/download/plugins/atlassian-plugin-sdk-tgz && \
    tar -xvzf atlassian-plugin-sdk.tgz -C /tmp/atlas-sdk && \
    rm atlassian-plugin-sdk.tgz &&  \
    mkdir /opt/atlas-sdk && mv /tmp/atlas-sdk/*/* /opt/atlas-sdk

ADD atlas-prefetch.sh /usr/bin/atlas-prefetch
RUN chmod +x /usr/bin/atlas-prefetch

ADD atlas-mvn-wrapper.sh /usr/bin/atlas-mvn-wrapper
RUN chmod +x /usr/bin/atlas-mvn-wrapper

ENV PATH /opt/atlas-sdk/bin:$PATH

WORKDIR /root
ADD pom.xml .

RUN atlas-prefetch && rm -rf target

HEALTHCHECK --start-period=5m CMD [ "/usr/bin/wget", "-T", "5", "--spider", "http://localhost:2990/jira"] 

CMD MVN_CMD="$(atlas-version | sed -ne 's/^Maven home: \(.*\)$/\1\/bin\/mvn/p') --offline" \
    ATLAS_MVN=/usr/bin/atlas-mvn-wrapper \
    atlas-run
