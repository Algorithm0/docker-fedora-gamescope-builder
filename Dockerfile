FROM fedora:latest

RUN dnf update -y

RUN dnf install -y git \
  meson \
  gcc \
  clang \
  ninja-build \
  cmake \
  pkgconfig \
  glibc-devel \
  glibc-devel.i686

RUN dnf install -y libXNVCtrl-devel \
  pipewire-libs \
  pipewire-devel hwdata \
  hwdata-devel \
  wayland-devel \
  vulkan-loader-devel \
  wayland-protocols-devel \
  libXdamage-devel \
  libXcomposite-devel \
  libXcursor-devel \
  libXext-devel \
  libXxf86vm-devel \
  libXtst-devel \
  libXres-devel \
  libXmu-devel \
  libdrm-devel \
  libxkbcommon-devel \
  libcap-devel SDL2-devel \
  pixman-devel \
  systemd-devel \
  libseat \
  libseat-devel \
  libinput-devel \
  xorg-x11-server-Xwayland-devel \
  xcb-util-wm-devel \
  xcb-util-errors-devel \
  libxcb \
  libxcb-devel \
  xcb-util-renderutil-devel \
  edid-decode

RUN dnf install -y glslang
  
# RUN dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
#   xorg-x11-drv-nvidia akmod-nvidia vulkan vulkan-tools

ADD gamescope-build /usr/bin/gamescope-build
ADD installers /scripts
RUN /scripts/libavif-installer.sh
# RUN /scripts/openvr-installer.sh
RUN rm -rf /scripts

#Create user 'user' with password 'fedora'
RUN useradd -ms /bin/bash -G wheel -p $(perl -e 'print crypt($ARGV[0], "password")' 'fedora') user
USER user
WORKDIR /home/user/
