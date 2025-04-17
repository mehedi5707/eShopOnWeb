pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        IMAGE_NAME = 'mehedi5707/eshoponweb'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:latest ${WORKSPACE}'
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-creds') {
                        docker.image("${IMAGE_NAME}:latest").push('latest')
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
  steps {
    withEnv(["KUBECONFIG=/var/lib/jenkins/.kube/config"]) {
      sh 'kubectl apply -f deployment.yaml'
    }
  }
}

        stage('Verify Deployment') {
            steps {
                sh 'kubectl rollout status deployment/my-app'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
