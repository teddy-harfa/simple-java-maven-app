node {
    checkout scm
    docker.image('maven:3.9.2').inside('-v /root/.m2:/root/.m2'){
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