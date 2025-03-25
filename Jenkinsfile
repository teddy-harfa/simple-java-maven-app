node {
    checkout scm
    docker.image('maven:3.9.2').inside('-v $HOME/.m2:/var/maven/.m2:z -e MAVEN_CONFIG=/var/maven/.m2 -e MAVEN_OPTS="-Duser.home=/var/maven"'){
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