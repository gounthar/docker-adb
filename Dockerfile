FROM alpine:3.12.1

# Set up insecure default key
RUN mkdir -m 0750 /root/.android
ADD files/insecure_shared_adbkey /root/.android/adbkey
ADD files/insecure_shared_adbkey.pub /root/.android/adbkey.pub

RUN set -xeo pipefail && \
    apk update && \
    apk add android-tools wget ca-certificates tini --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ && \
    rm -r /var/cache/apk/APKINDEX.* && \
    adb --version

# Expose default ADB port
EXPOSE 5037

# Hook up tini as the default init system for proper signal handling
ENTRYPOINT ["/sbin/tini", "--"]

# Start the server by default
CMD ["adb", "-a", "-P", "5037", "server", "nodaemon"]

