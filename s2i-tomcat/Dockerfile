# s2i-tomcat
FROM openshift/base-centos7

# TODO: Put the maintainer name in the image metadata
LABEL maintainer="robert.diers@accenture.com"

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 1.0

# set env variables
ENV JAVA_VERSON 1.8.0
ENV MAVEN_VERSION 3.6.3
ENV TOMCAT_VERSION 9.0.31

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building Java apps running on Tomcat" \
      io.k8s.display-name="builder Tomcat" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,java,java8,mavan,maven3,tomcat"

# TODO: Install required packages here:
RUN yum update -y && \
 yum install -y curl && \
 yum install -y nc && \
 yum install -y java-$MAVEN_VERSION-openjdk java-$MAVEN_VERSION-openjdk-devel && \
 yum clean all
 
# Download Maven
RUN curl -fsSL http://ftp.fau.de/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# Download Tomcat
RUN curl -fsSL http://apache.lauf-forum.at/tomcat/tomcat-9/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-tomcat-$TOMCAT_VERSION /tomcat
RUN chmod -R 777 /tomcat

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 8080

# TODO: Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]
