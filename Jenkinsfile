pipeline {
    agent any

    stages {
        stage('1. Preparación') {
            steps {
                // Limpiamos cualquier rastro anterior
                sh 'docker compose down || true'
                sh 'docker rm -f app-practica || true'
            }
        }

        stage('2. SonarQube Analysis') {
            steps {
                // Usamos el servidor que configuramos en el paso anterior
                withSonarQubeEnv('Sonar') {
                    // Esto ejecuta el escáner sobre tu app.py
                    sh 'docker run --rm -e SONAR_HOST_URL="http://sonarqube:9000" -v "${WORKSPACE}:/usr/src" sonarsource/sonar-scanner-cli -Dsonar.projectKey=mi-proyecto-python -Dsonar.sources=.'
                }
            }
        }

        stage('3. Build & Deploy') {
            steps {
                // Levantamos la app si el análisis terminó
                sh 'docker compose up -d --build'
            }
        }
    }
}
