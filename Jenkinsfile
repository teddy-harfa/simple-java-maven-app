node {
    checkout scm
    stage('Build') {
        //build application
        docker.image('maven:3.9.9-eclipse-temurin-21').inside('-v /root/.m2:/root/.m2'){
            sh 'mvn -B -DskipTests clean package'
        }
    }
    stage('Test') {
        //test application
        docker.image('maven:3.9.9-eclipse-temurin-21').inside('-v /root/.m2:/root/.m2'){
            sh 'mvn test'
        }
    }
    stage('Manual Approval') {
        //approve deploy application
        input message: 'Lanjutkan ke tahap Deploy? (Klik "Proceed" untuk melakukan approve)'
    }
    stage('Deploy') { 
        //deploy application
        docker.image('maven:3.9.9-eclipse-temurin-21').inside('-v /root/.m2:/root/.m2'){
            sh './jenkins/scripts/deliver.sh'
            // export NAME="$(NAME)"
            // export VERSION="$(VERSION)"
            //copy file via ssh then test run
            sshPublisher(
                publishers: [
                    sshPublisherDesc(
                        // configName: 'Aws ec2', 
                        configName: 'local', 
                        transfers: [
                            sshTransfer(
                                cleanRemote: false, 
                                excludes: '', 
                                execCommand: "java -jar runnable.jar", 
                                execTimeout: 120000, 
                                flatten: false, 
                                makeEmptyDirs: false, 
                                noDefaultExcludes: false, 
                                patternSeparator: '[, ]+', 
                                remoteDirectory: '', 
                                remoteDirectorySDF: false, 
                                removePrefix: 'target', 
                                sourceFiles: "target/runnable.jar"
                            )
                        ], 
                        usePromotionTimestamp: false, 
                        useWorkspaceInPromotion: false, 
                        verbose: true
                    )
                ]
            )
            //biarkan aplikasi berjalan 1 menit
            sleep time: 1, unit: 'MINUTES'
        }
    }
}