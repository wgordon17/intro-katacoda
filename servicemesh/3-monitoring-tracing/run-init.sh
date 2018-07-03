#!/bin/bash
ssh root@host01 "wget -c https://github.com/istio/istio/releases/download/0.6.0/istio-0.6.0-linux.tar.gz -P /root/installation"

ssh root@host01 "git --work-tree=/root/projects/istio-tutorial/ --git-dir=/root/projects/istio-tutorial/.git pull"
ssh root@host01 "rm -rf /root/projects/rhoar-getting-started /root/temp-pom.xml"

ssh root@host01 "tar -zxvf /root/installation/istio-0.6.0-linux.tar.gz -C /root/installation"

ssh root@host01 "sleep 20; oc login -u system:admin; oc adm policy add-cluster-role-to-user cluster-admin admin"

ssh root@host01 "oc adm policy add-cluster-role-to-user cluster-admin developer"
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system"
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z default -n istio-system"

ssh root@host01 "oc apply -f /root/installation/istio-0.6.0/install/kubernetes/istio.yaml"

ssh root@host01 "oc expose svc istio-ingress -n istio-system"


#Install Microservices
ssh root@host01 "oc new-project tutorial ; oc adm policy add-scc-to-user privileged -z default -n tutorial"

ssh root@host01 "mvn package -f /root/projects/istio-tutorial/customer/java/springboot -DskipTests"
ssh root@host01 "docker build -t example/customer /root/projects/istio-tutorial/customer/java/springboot"
ssh root@host01 "oc apply -f <(/root/installation/istio-0.6.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial/customer/kubernetes/Deployment.yml) -n tutorial"
ssh root@host01 "oc create -f /root/projects/istio-tutorial/customer/kubernetes/Service.yml -n tutorial"
ssh root@host01 "oc expose service customer -n tutorial"

ssh root@host01 "mvn package -f /root/projects/istio-tutorial/preference/java/springboot -DskipTests"
ssh root@host01 "docker build -t example/preference:v1 /root/projects/istio-tutorial/preference/java/springboot"
ssh root@host01 "oc apply -f <(/root/installation/istio-0.6.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial/preference/kubernetes/Deployment.yml) -n tutorial"
ssh root@host01 "oc create -f /root/projects/istio-tutorial/preference/kubernetes/Service.yml -n tutorial"

ssh root@host01 "mvn package -f /root/projects/istio-tutorial/recommendation/java/vertx -DskipTests"
ssh root@host01 "docker build -t example/recommendation:v1 /root/projects/istio-tutorial/recommendation/java/vertx"
ssh root@host01 "oc apply -f <(/root/installation/istio-0.6.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial/recommendation/kubernetes/Deployment.yml) -n tutorial"
ssh root@host01 "oc create -f /root/projects/istio-tutorial/recommendation/kubernetes/Service.yml -n tutorial"

