from ubuntu

env DEBIAN_FRONTEND=noninteractive

run sed -i "/deb-src/d" /etc/apt/sources.list && \
  apt-get update && apt-get install -y gnupg wget && \
  wget -q https://dl-ssl.google.com/linux/linux_signing_key.pub -O /linux_signing_key.pub && \
  apt-key add /linux_signing_key.pub && \
  echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
  apt-get update && \
  apt-get install -y google-chrome-stable bzip2 libxss1 lsof libqt5widgets5 libqt5multimedia5 libqt5xml5 libqt5sql5 libqt5xmlpatterns5 libqt5websockets5 materia-gtk-theme papirus-icon-theme dmz-cursor-theme fonts-noto firefox && \
  rm /etc/alternatives/x-cursor-theme && \
  ln -s /usr/share/icons/DMZ-Black/cursor.theme /etc/alternatives/x-cursor-theme && \
  rm -rf /var/lib/apt/lists/*
