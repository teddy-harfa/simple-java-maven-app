node {
    checkout scm
    docker.image('maven:3.9.9-eclipse-temurin-11').inside('-v ~/.m2:/var/maven/.m2 -it --rm -u $(id -u) -e MAVEN_CONFIG=/var/maven/.m2 maven mvn -Duser.home=/var/maven archetype:generate'){
        stage('Build') {
            //build application
            sh 'mvn -B -DskipTests clean package'
        }
        stage('Test') {
            //test application
            sh 'mvn test'
        }
    }
}