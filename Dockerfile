FROM mitchtech/arm-adb

RUN ["cross-build-start"]
# Set up insecure default key
ADD files/android.rules /etc/udev/rules.d/51-android.rules
RUN chmod 644 /etc/udev/rules.d/51-android.rules && chown root. /etc/udev/rules.d/51-android.rules && apt-get update && \
apt-get upgrade && \
apt-get install -y -q android-tools* ca-certificates curl usbutils --no-install-recommends && rm -rf /var/lib/apt/lists/* 

RUN ["cross-build-end"]
