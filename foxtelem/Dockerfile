FROM debian:bookworm

WORKDIR /home/docker
ENV USER=root

# Install required packages
RUN apt-get update && apt-get install -y \
  tightvncserver \
  wget \
  zip

# Setup VNC server
RUN mkdir /root/.vnc \
  && echo "majortom" | vncpasswd -f > /root/.vnc/passwd \
  && chmod 600 /root/.vnc/passwd
EXPOSE 5901

# Install Java JDK 8
RUN mkdir -p /etc/apt/keyrings
RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
RUN echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
RUN apt-get update && apt-get install -y \
  temurin-8-jdk

# Download FoxTelem
RUN wget --quiet http://amsat.us/FoxTelem/linux/FoxTelem_1.12z3_linux.tar.gz
RUN tar --strip-components=1 -zxf FoxTelem_1.12z3_linux.tar.gz
RUN rm FoxTelem_1.12z3_linux.tar.gz

# FoxTelem lacks the native library of libusb4java for aarch64 platforms, this patches the jar file with the required .so file
COPY org org
RUN zip -ur FoxTelem.jar org
RUN rm -rf org

# Copy FoxTelem configuration files into the image
RUN mkdir -p /root/.FoxTelem
COPY FoxTelem.properties /root/.FoxTelem/.
COPY CubeSat_Simulator_DUV.dat spacecraft/.
COPY CubeSat_Simulator_PSK.dat spacecraft/.

# Create a volume to be shared with other docker containers
RUN mkdir FOXDB
VOLUME /home/docker/FOXDB

ENTRYPOINT vncserver -geometry 1920x1080 && DISPLAY=:1 java -jar FoxTelem.jar
