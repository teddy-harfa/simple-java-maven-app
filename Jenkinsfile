node {
    checkout scm
    stage('Build') {
        //build application
        docker.image('maven:3.9.2-eclipse-temurin-11').inside('-v /root/.m2:/root/.m2'){
            sh 'mvn -B -DskipTests clean package'
        }
    }
    stage('Test') {
        //test application
        docker.image('maven:3.9.2-eclipse-temurin-11').inside('-v /root/.m2:/root/.m2'){
            sh 'mvn test'
        }
    }
}