pipeline {
    agent any

    stages {
        stage('1. Limpieza y Preparación') {
            steps {
                // Ya no usamos 'dir', ejecutamos directamente en la raíz del workspace
                sh 'docker compose down || true'
                sh 'docker rm -f app-practica || true'
            }
        }

        stage('2. Build & Deploy') {
            steps {
                // Aquí también quitamos el 'dir'
                sh 'docker compose up -d --build'
            }
        }

        stage('3. Verificación') {
            steps {
                sh 'docker ps'
                // Esto mostrará el mensaje de tu app.py en la consola de Jenkins
                sh 'docker logs app-practica'
            }
        }
    }
}
