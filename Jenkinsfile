pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'ForJenkins2', url: 'https://github.com/mehedi5707/eShopOnWeb.git'
            }
        }

        stage('Build Docker Image') {
    steps {
        sh 'docker build -t mehedi5707/eshoponweb:latest ${WORKSPACE}'
    }
}
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'dockerhub-creds', url: 'https://index.docker.io/v1/']) {
                        docker.image('mehedi5707/eshoponweb:latest').push('latest')
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
