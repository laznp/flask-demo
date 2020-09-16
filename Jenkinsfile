pipeline {
	agent any
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
					def images = docker.build("laznp/flask-demo:0.${BUILD_NUMBER}")
					images.push("0.${BUILD_NUMBER}")
				}
				sh "docker rmi -f \$(docker images laznp/flask-demo -q)"
			}
		}
	}
	// post {
	// 	success {
	// 		echo "Deploying Image to Server"
	// 		script {
	// 			sh "ansible-playbook -i inventory.yml deploy.yml"
	// 		}
	// 	}
	// }
}
