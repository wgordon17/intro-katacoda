# General Preparation
ssh root@host01 'git clone --depth 1 https://github.com/fatherlinux/container-internals-lab.git ~/labs'

# Lab 1
ssh root@host01 'cp ~/labs/lab1-step3/mega-proc.sh /usr/bin/mega-proc.sh'

# Lab 2
ssh root@host01 'git clone --depth 1 --single-branch --branch centos7 https://github.com/fatherlinux/container-supply-chain.git ~/labs/lab2-step4/'

# Lab 3
ssh root@host01 'cp ~/labs/lab3-step1/atomic-openshift-master.service /etc/systemd/system/atomic-openshift-master.service'
ssh root@host01 'cp ~/labs/lab3-step1/atomic-openshift-node.service /etc/systemd/system/atomic-openshift-node.service'
ssh root@host01 'systemctl disable --now origin.service'
ssh root@host01 'systemctl enable --now atomic-openshift-master.service; systemctl enable --now atomic-openshift-node.service'
ssh root@host01 'rpm -ivh http://mirror.centos.org/centos/7/os/x86_64/Packages/strace-4.12-6.el7.x86_64.rpm'

# Lab 4
ssh root@host01 'git clone --depth 1 --single-branch --branch lab4-step1 https://github.com/fatherlinux/wordpress-demo.git ~/labs/lab4-step1'
ssh root@host01 '~/labs/lab4-step1/create.sh'
ssh root@host01 'sed -i s/wpfrontend-wordpress.apps.example.com/`hostname`/ ~/labs/lab4-step1/wordpress-objects.yaml'
ssh root@host01 'rpm -ivh http://mirror.centos.org/centos/7/os/x86_64/Packages/httpd-tools-2.4.6-80.el7.centos.x86_64.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/apr-1.4.8-3.el7_4.1.x86_64.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/apr-util-1.5.2-6.el7.x86_64.rpm'

# Final Preparation
ssh root@host01 'docker pull rhel7'
ssh root@host01 'docker pull rhel7-atomic'
ssh root@host01 'docker pull nate/dockviz'
ssh root@host01 'docker pull centos'
ssh root@host01 'docker pull openshift3/mysql-55-rhel7'
ssh root@host01 '/var/lib/openshift/openshift admin policy add-cluster-role-to-user cluster-admin admin'
