FROM debian:stretch

# Set up insecure default key
ADD files/51-android.rules /etc/udev/rules.d/51-android.rules
RUN chmod 644 /etc/udev/rules.d/51-android.rules && chown root. /etc/udev/rules.d/51-android.rules && apt-get update && \
apt-get upgrade -y && \
apt-get install -y -q android-tools* ca-certificates curl usbutils --no-install-recommends && rm -rf /var/lib/apt/lists/* 

FROM mitchtech/arm-adb
COPY /root/.android/adbkey.pub /root/.android/adbkey.pub 
