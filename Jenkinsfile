node {
    withDockerContainer(args: '-v /root/.m2:/root/.m2', image: 'maven:3.9.0'){
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