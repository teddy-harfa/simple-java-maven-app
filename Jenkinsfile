node {
    agent any
    checkout scm
    stage('Build') {
        //build application
        sh 'mvn -B -DskipTests clean package'
    }
    stage('Test') {
        //test application
        sh 'mvn test'
    }
}