FROM fourplusone/docker-atlas:latest

LABEL maintainer="mba@fourplusone.de"

RUN atlas-prefetch --product jira

CMD atlas-run-standalone --product jira --http-port 2990 --server 0.0.0.0 --jvmargs -Xmx4096M -DskipAllPrompts=true
