CENTOS 镜像加速
sudo cp -n /lib/systemd/system/docker.service /etc/systemd/system/docker.service
sudo sed -i "s|ExecStart=/usr/bin/docker daemon|ExecStart=/usr/bin/docker daemon --registry-mirror=https://registry.docker-cn.com|g" /etc/systemd/system/docker.service
sudo sed -i "s|ExecStart=/usr/bin/dockerd|ExecStart=/usr/bin/dockerd --registry-mirror=https://registry.docker-cn.com|g" /etc/systemd/system/docker.service
sudo systemctl daemon-reload
sudo service docker restart