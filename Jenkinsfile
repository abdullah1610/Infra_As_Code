pipeline {
	agent any


	parameters {
		booleanParam(name: 'AUTO_APPLY', defaultValue: false, description: 'If true, Terraform will apply automatically after plan (use with caution)')
	}

	triggers {
		// For GitHub webhook pushes (requires GitHub plugin / Multibranch handling)
		githubPush()
	}

	stages {
		stage('Checkout') {
			steps {
				checkout scm
			}
		}

		stage('Terraform Init') {
			steps {
				withCredentials([usernamePassword(credentialsId: 'aws-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'WS_SECRET_ACCESS_KEY')]) {
					sh 'terraform init -input=false'
				}
			}
		}

		stage('Terraform Plan') {
			steps {
				withCredentials([usernamePassword(credentialsId: 'aws-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
					sh 'terraform plan -out=tfplan -input=false'
					sh 'terraform show -no-color tfplan > plan.txt || true'
					archiveArtifacts artifacts: 'plan.txt', fingerprint: true
				}
			}
		}

		stage('Terraform Apply') {
			when {
				anyOf {
					expression { return params.AUTO_APPLY }
				}
			}
			steps {
				withCredentials([usernamePassword(credentialsId: 'aws-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
					sh 'terraform apply -auto-approve tfplan'
				}
			}
		}
	}

	post {
		always {
			archiveArtifacts artifacts: '**/.terraform/**', allowEmptyArchive: true
		}
		failure {
			mail to: 'dev-team@example.com', subject: "Build failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}", body: "Check Jenkins for details"
		}
	}
}

