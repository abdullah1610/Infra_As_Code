pipeline {
    agent any

    parameters {
        booleanParam(
            name: 'AUTO_APPLY',
            defaultValue: false,
            description: 'If true, Terraform apply will run automatically'
        )
    }

    options {
        timestamps()
    }

    stages {

        stage('Terraform Init') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'aws-creds',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )
                ]) {
                    bat 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                bat 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'aws-creds',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )
                ]) {
                    bat 'terraform plan -out=tfplan -input=false'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { return params.AUTO_APPLY }
            }
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'aws-creds',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )
                ]) {
                    bat 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }
}
