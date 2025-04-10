#!/usr/bin/env bash

echo 'The following Maven command installs your Maven-built Java application'
echo 'into the local Maven repository, which will ultimately be stored in'
echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
echo 'volume).'
set -x
mvn jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'The following command extracts the value of the <name/> element'
echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'
set -x
NAME=`mvn -q -DforceStdout help:evaluate -Dexpression=project.name`
set +x

echo 'The following command behaves similarly to the previous one but'
echo 'extracts the value of the <version/> element within <project/> instead.'
set -x
VERSION=`mvn -q -DforceStdout help:evaluate -Dexpression=project.version`
set +x

# echo 'The following command runs and outputs the execution of your Java'
# echo 'application (which Jenkins built using Maven) to the Jenkins UI.'
# set -x
# java -jar target/${NAME}-${VERSION}.jar
set -x 
#cat target/${NAME}-${VERSION}.jar | ssh -i "/home/latihan_ci/deploy-app.pem" ec2-user@ec2-13-251-156-231.ap-southeast-1.compute.amazonaws.com "cat > runnable.jar" && java -jar runnable.jar
pwd
ls /home/
ls /home/latihan_ci/
scp target/${NAME}-${VERSION}.jar -i "/home/latihan_ci/deploy-app.pem" dicoding@172.27.176.246:/home/dicoding/
ssh -i "/home/latihan_ci/deploy-app.pem" dicoding@172.27.176.246 "java -jar runnable.jar"
set +x

