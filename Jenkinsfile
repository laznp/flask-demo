pipeline {
	agent any
	environment {
		PROMOTE_PRODUCTION = "no"
	}
	options {
		ansiColor('xterm')
	}
	stages {
		stage('Unit Testing') {
			steps {
				sh """
				echo "[+] Start Unit Testing [+]"
				sleep 3
				echo "[+] Done Unit Testing [+]"
				"""
			}
		}
		stage("Building Image and Push to Docker Hub") {
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
					// env.PROMOTE_PRODUCTION = input message: 'Deploy to production?', ok: 'Yes'
					env.PROMOTE_PRODUCTION = input message: 'Deploy to production?', ok: 'Yes', parameters: [[
						$class: 'ChoiceParameterDefinition',
						choices: ['no','yes'].join('\n'),
						name: 'input',
						description: 'Deploy?'
					]]
				}
			}
		}
		stage("Deploying To Production") {
			steps {
				script {
					if (env.PROMOTE_PRODUCTION == "yes") {
						echo "Deploy"
					} else {
						currentBuild = 'ABORTED'
					}
				}
			}
		}
	}
}
