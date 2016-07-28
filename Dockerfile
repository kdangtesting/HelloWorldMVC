FROM tomcat:8.0-jre8
COPY /home/travis/build/kdangtesting/HelloWorldMVC/target/HelloWorldMVC-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/