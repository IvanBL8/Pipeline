pipeline {
    agent any

    stages {
        stage('1. Limpieza y Preparación') {
            steps {
                dir('/var/jenkins_home/workspace/mi-proyecto') {
                    // 1. Intenta limpieza normal
                    sh 'docker compose down || true'
                    // 2. FUERZA BRUTA: Borra el contenedor por nombre si sigue ahí
                    sh 'docker rm -f app-practica || true'
                }
            }
        }

        stage('2. Build & Deploy') {
            steps {
                dir('/var/jenkins_home/workspace/mi-proyecto') {
                    sh 'docker compose up -d --build'
                }
            }
        }

        stage('3. Verificación') {
            steps {
                sh 'docker ps'
                // Esto mostrará el "Hola Mundo" en la consola de Jenkins
                sh 'docker logs app-practica'
            }
        }
    }
}
