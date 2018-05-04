ssh root@host01 "curl -k --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -"
ssh root@host01 "yum -y install nodejs npm"
ssh root@host01 "oc project openshift"
ssh root@host01 "oc create -f /opt/amq-broker-71-basic.yaml -n openshift"
ssh root@host01 "oc create -f /opt/amq-7-image-streams.json -n openshift"
ssh root@host01 "git clone https://github.com/hguerrero/amq-examples.git /root/projects/tmp"
ssh root@host01 "mv -f /root/projects/tmp/* /root/projects/amq-examples/"