pipeline {
    agent any

    stages {
        stage('1. Preparación') {
            steps {
                echo 'Limpiando contenedores previos...'
                sh 'docker compose down || true'
                sh 'docker rm -f app-practica || true'
            }
        }

        stage('2. SonarQube Analysis') {
            steps {
                echo 'Iniciando análisis de código en SonarQube...'
                // 'Sonar' debe coincidir con el nombre en Administrar Jenkins > System
                withSonarQubeEnv('Sonar') {
                    sh '''
                    docker run --rm \
                    --network sistema-jenkins_devops-net \
                    -e SONAR_HOST_URL="http://sonarqube:9000" \
                    -e SONAR_TOKEN="${SONAR_AUTH_TOKEN}" \
                    -v "${WORKSPACE}:/usr/src" \
                    sonarsource/sonar-scanner-cli \
                    -Dsonar.projectKey=mi-proyecto-python \
                    -Dsonar.sources=.
                    '''
                }
            }
        }

        stage('3. Build & Deploy') {
            steps {
                echo 'Construyendo y levantando la aplicación Python...'
                sh 'docker compose up -d --build'
            }
        }
    }

    post {
        success {
            echo '¡Pipeline finalizado con éxito!'
        }
        failure {
            echo 'El Pipeline ha fallado. Revisa los logs.'
        }
    }
}
