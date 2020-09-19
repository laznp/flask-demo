pipeline {
	agent any
	options {
		ansiColor('xterm')
	}
	stages {
		stage("Build and Push Image") {
			steps {
				script {
					docker.withRegistry('','dockerhub') { 
						def images = docker.build("laznp/flask-demo:0.${BUILD_NUMBER}")
						images.push("0.${BUILD_NUMBER}")
					}
				}
				sh "docker rmi -f \$(docker images laznp/flask-demo -q)"
			}
		}
		stage("Proceed Deployment?") {
			steps {
				script {
					input message: 'Deploy to production?', ok: 'Yes'
				}
			}
		}
		stage("Deploying To Production") {
			steps {
				sh "sed -i 's|<tag_placeholder>|0.${BUILD_NUMBER}|g' deploy.yml"
				sh "ansible-playbook -i inventory.yml deploy.yml"
			}
		}
	}
}
