FROM mitchtech/arm-adb

RUN ["cross-build-start"]
# Set up insecure default key
ADD files/android.rules /etc/udev/rules.d/51-android.rules
RUN chmod 644 /etc/udev/rules.d/51-android.rules && chown root. /etc/udev/rules.d/51-android.rules

RUN ["cross-build-end"]
