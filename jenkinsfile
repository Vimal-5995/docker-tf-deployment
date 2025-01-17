pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your/repo' 
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'cd terraform && terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'cd terraform && terraform plan -out=plan.out'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'cd terraform && terraform apply plan.out'
            }
        }
    }
}
