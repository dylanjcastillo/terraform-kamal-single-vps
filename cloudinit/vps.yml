package_update: true
package_upgrade: true

timezone: Europe/Berlin

manage_etc_hosts: true

packages:
  - docker.io
  - curl
  - git
  - snapd

users:
  - default
  - name: kamal
    groups:
      - sudo
    sudo:
      - ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ${ssh_vps_kamal_key}
    uid: 1000

write_files:
  - path: /etc/netplan/01-netplan.yaml
    content: |
      network:
        version: 2
        ethernets:
          eth0:
            nameservers:
              addresses:
                - 1.1.1.1
                - 1.0.0.1
    permissions: "0600"

runcmd:
  - netplan apply
  - sed -i '/PermitRootLogin/d' /etc/ssh/sshd_config
  - echo "PermitRootLogin no" >> /etc/ssh/sshd_config
  - systemctl restart sshd
  - usermod -aG docker kamal
  - docker network create --driver bridge private_network
  - snap install btop
  - apt install unattended-upgrades apt-listchanges -y
  - DEBIAN_FRONTEND=noninteractive dpkg-reconfigure -plow unattended-upgrades
  - echo 'Unattended-Upgrade::Automatic-Reboot "true";' | tee -a /etc/apt/apt.conf.d/50unattended-upgrades
  - echo 'Unattended-Upgrade::Automatic-Reboot-Time "05:00";' | tee -a /etc/apt/apt.conf.d/50unattended-upgrades
  - mkdir -p /letsencrypt && touch /letsencrypt/acme.json && chmod 600 /letsencrypt/acme.json
  - chown -R kamal:kamal /letsencrypt
  - reboot
  # If you need to do anything else, add it here
  - mkdir -p /data
  - mkdir -p /db
  - chown -R 1000:1000 /db /data
