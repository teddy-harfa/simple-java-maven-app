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
            //copy file via ssh then test run
            sshPublisher(
                publishers: [
                    sshPublisherDesc(
                        configName: 'Aws ec2', 
                        transfers: [
                            sshTransfer(
                                cleanRemote: false, 
                                excludes: '', 
                                execCommand: 'java -jar target/${NAME}-${VERSION}.jar', 
                                execTimeout: 120000, 
                                flatten: false, 
                                makeEmptyDirs: false, 
                                noDefaultExcludes: false, 
                                patternSeparator: '[, ]+', 
                                remoteDirectory: '', 
                                remoteDirectorySDF: false, 
                                removePrefix: '', 
                                sourceFiles: 'target/${NAME}-${VERSION}.jar'
                            )
                        ], 
                        usePromotionTimestamp: false, 
                        useWorkspaceInPromotion: false, 
                        verbose: false
                    )
                ]
            )
            //biarkan aplikasi berjalan 1 menit
            sleep time: 1, unit: 'MINUTES'
        }
    }
}