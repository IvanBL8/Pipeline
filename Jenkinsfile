pipeline {
    agent any

    stages {
        stage('1. Preparación') {
            steps {
                dir('/var/jenkins_home/workspace/mi-proyecto') {
                    sh 'ls -la'
                }
            }
        }

        stage('2. Limpieza de versiones previas') {
            steps {
                dir('/var/jenkins_home/workspace/mi-proyecto') {
                    // Detiene y elimina contenedores, redes y volúmenes antiguos de este proyecto
                    sh 'docker compose down'
                }
            }
        }

        stage('3. Build & Deploy App') {
            steps {
                dir('/var/jenkins_home/workspace/mi-proyecto') {
                    sh 'docker compose up -d --build'
                }
            }
        }

        stage('4. Verify') {
            steps {
                sh 'docker ps'
                // Verificamos los logs del contenedor recién creado
                sh 'docker logs app-practica'
            }
        }
    }
}
