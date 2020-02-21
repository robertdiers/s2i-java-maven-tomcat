# build local builder image
cd s2i-tomcat
sudo docker build -t s2i-tomcat:latest .

# use builder image to build the code to docker
/home/robertdiers/Documents/tools/s2i/s2i build https://github.com/robertdiers/example-spring-boot-rest s2i-tomcat:latest sbr-s2i-tomcat:latest

# start local docker image
sudo docker run -p 8080:8080 sbr-s2i-tomcat:latest

# push builder image to openshift
oc login -u developer
# jetzt das s2i builder image mit dem docker des minishift bauen
docker build -t myproject/s2i-tomcat:latest .
minishift docker-env
eval $(minishift docker-env)
docker tag myproject/s2i-tomcat:latest 172.30.1.1:5000/myproject/s2i-tomcat:latest
docker push 172.30.1.1:5000/myproject/s2i-tomcat:latest
#oc import-image s2i-tomcat --from="172.30.1.1:5000/myproject/s2i-tomcat:latest" --confirm

# deploy a new app using the s2i builder image
oc new-app myproject/s2i-tomcat~https://github.com/robertdiers/example-spring-boot-rest --name=sbr-tomcat
oc expose service sbr-tomcat --path=/ --port=8080

