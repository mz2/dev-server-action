FROM docker:cli

RUN apk add --no-cache curl

COPY entrypoint.sh /entrypoint.sh
COPY cleanup.sh /cleanup.sh
RUN chmod +x /entrypoint.sh /cleanup.sh

ENTRYPOINT ["/entrypoint.sh"]
