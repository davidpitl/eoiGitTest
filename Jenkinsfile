pipeline{
    agent any
    environment{
        registry= "davidpitl/eoiGitTest"
        registryCredentials="dockerhub"
        project="jenkins-example"
        projectVersion="1.0"
        repository="https://github.com/davidpitl/eoiGitTest.git"
        repositoryCredentials="github"
    }
    stages{
        stage('Limpiar Workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Descargar codigo'){
            steps{
                script{
                    git branch: 'main',
                        credentialsId: repositoryCredentials,
                        url: repository
                }
            }
        }

        stage('Analisis del codigo'){
            environment{
                scannerHome= tool 'Sonar'
            }
            steps{
                script{
                    withSonarQubeEnv('Sonar'){
                        sh "${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=$project \
                        -Dsonar.projectName=$project \
                        -Dsonar.projectVersion=$projectVersion \
                        -Dsonar.sources=./"
                    }
                }
            }
        }

        stage('Build'){
            steps{
                script{
                    dockerImage= docker.build registry
                }
            }
        }

        stage('Test'){
            steps{
                script{
                    try{
                        sh 'docker run --rm my-dice-app'
                    }finally{
                        sh 'docker rm $project'
                    }
                }
            }
        }

        stage('Desplegar'){
            steps{
                script{
                    docker.withRegistry('',registryCredentials ){
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Limpiar'){
            steps{
                script{
                    sh 'docker rmi $registry'
                }
            }
        }

    }
    post {
        always{
            echo 'Registro del docker'
        }
        success {
            echo 'El pipeline ha terminado correctamente'
        }
        failure {
            echo 'El pipeline ha fallado'
        }
    }

}