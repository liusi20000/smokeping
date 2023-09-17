FROM linuxserver/smokeping:latest

# set version label
ARG BUILD_DATE
ARG VERSION
ARG SMOKEPING_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL build_version="Extension to update Smokeping"
LABEL maintainer="Divya Mahajan"

# copy tcpping script
COPY tcpping /usr/bin/tcpping

# add local files
COPY root/ /

# Update Smokeping
RUN \
    curl -L -o /tmp/smokeping.zip https://github.com/oetiker/SmokePing/archive/master.zip \
    echo "status::success"
&&  cd /tmp \
echo "status::success" \
&&  unzip -o smokeping.zip \
echo "status::success" \
&&  cp -rv /tmp/SmokePing-master/htdocs/css /usr/share/webapps/smokeping/ \
echo "status::success" \
&&  cp -rv /tmp/SmokePing-master/htdocs/js /usr/share/webapps/smokeping/ \
echo "status::success" \
&&  rm -rf /usr/share/webapps/smokeping/cropper \
echo "status::success" \
&&  cp /tmp/SmokePing-master/etc/basepage.html.dist /etc/smokeping/basepage.html \
echo "status::success" \
&&  cp /tmp/SmokePing-master/bin/smokeping /usr/bin \
echo "status::success" \
&&  cp /tmp/SmokePing-master/bin/smokeping_cgi /usr/bin \
echo "status::success" \
&&  cp /tmp/SmokePing-master/bin/smokeinfo /usr/bin \
echo "status::success" \
&&  cp /tmp/SmokePing-master/lib/*.pm /usr/share/perl5/vendor_perl/ \
echo "status::success" \
&&  cp -rv /tmp/SmokePing-master/lib/Smokeping/* /usr/share/perl5/vendor_perl/Smokeping \
echo "status::success" \
&&  chmod ug+s /usr/bin/tcpping \
echo "status::success" \
&&  chmod +rx /usr/bin/tcpping
echo "status::success" \
# ports and volumes
EXPOSE 80
VOLUME /config /data /cache
