# VERSION               0.1
# 커스텀 이미지를 토대로 컨테이너를 생성
FROM centos:centos7
MAINTAINER Deokjoon Kang <dchkang83@naver.com>

LABEL name="CentOS7 with JDK8 And Apache Tomcat 8"

# JAVA INSTALL
RUN yum -y install wget
RUN wget -c -O /tmp/jdk-8u25-linux-x64.rpm --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.rpm
RUN yum -y localinstall /tmp/jdk-8u25-linux-x64.rpm
RUN rm -f /tmp/jdk-8u25-linux-x64.rpm


# APACHE TOMCAT INSTALL
ENV APACHE_TOMCAT_INSTALL_DIR /usr/local/tomcat

RUN	yum install wget -y

RUN	wget "http://mirror.apache-kr.org/tomcat/tomcat-8/v8.5.5/bin/apache-tomcat-8.5.5.tar.gz" \
	&& tar xzvf ./apache-tomcat-8.5.5.tar.gz \
	&& rm ./apache-tomcat-8.5.5.tar.gz \
	&& mv ./apache-tomcat-8.5.5 /opt/apache-tomcat-8.5.5 \
	&& ln -s /opt/apache-tomcat-8.5.5 /usr/local/tomcat
	ENV CATALINA_HOME /usr/local/tomcat

	# sh 적용
	COPY entrypoint.sh /
	RUN chmod +x /entrypoint.sh

	#ADD entrypoint.sh /entrypoint.sh
	#RUN chmod +x /entrypoint.sh

	EXPOSE 8080 8009
	#VOLUME ["/tomcat/webapps", "/tomcat/logs"]
	CMD ["/entrypoint.sh"]
