#! /bin/bash

dir=$(dirname "$0")

echo "Dir: $dir"
apt install openjdk-8-jdk -y

useradd -M -d /opt/nexus -s /bin/bash -r nexus
echo "nexus   ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/nexus

# Extract /opt/nexus
tar -xzvf $dir/nexus.tar.gz -C /opt/
# Extract /opt/sonatype-work
tar -xzvf $dir/sonatype-work.tar.gz -C /opt/

chown -R nexus: /opt/nexus

# Create systemd unit
cp $dir/nexus.service /etc/systemd/system/nexus.service

systemctl daemon-reload
systemctl restart nexus
