pipeline {
    agent any

    environment {
        IMAGE_NAME = 'devops-web'
        KUBECONFIG = '/var/lib/jenkins/.kube/config'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-web:latest .'
            }
        }

        stage('Load Image into Minikube') {
            steps {
                sh 'sudo /usr/local/sbin/jenkins-minikube-load'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/'
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'kubectl rollout status deployment/devops-web --timeout=180s'
                sh 'kubectl get pods -l app=devops-web'
                sh 'kubectl get svc devops-web-service'
            }
        }
    }

    post {
        success {
            echo 'CI/CD deployment completed successfully!'
        }
        failure {
            echo 'CI/CD pipeline failed. Check console output.'
        }
    }
}
