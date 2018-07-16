FROM debian:stretch as base
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LC_ALL=C.UTF-8  

# Set up insecure default key
ADD files/51-android.rules /etc/udev/rules.d/51-android.rules
RUN chmod 644 /etc/udev/rules.d/51-android.rules && chown root. /etc/udev/rules.d/51-android.rules && apt-get update && \
apt-get upgrade -y && \
apt-get install -y -q android-tools* ca-certificates curl usbutils --no-install-recommends && rm -rf /var/lib/apt/lists/* 

WORKDIR /root/

RUN mkdir -p -m 0750 /root/.android 

COPY --from=mitchtech/arm-adb /root/.android/adbkey.pub .android/adbkey.pub 
COPY --from=mitchtech/arm-adb /root/.android/adbkey .android/adbkey

EXPOSE 5037/tcp
CMD adb -a -P 5037 server nodaemon
