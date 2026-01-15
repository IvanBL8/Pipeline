pipeline {
    agent any

    stages {
        stage('1. Preparación') {
            steps {
                echo 'Limpiando contenedores previos...'
                // Detenemos la app si ya estaba corriendo para evitar conflictos
                sh 'docker compose down || true'
                sh 'docker rm -f app-practica || true'
            }
        }

        stage('2. SonarQube Analysis') {
            steps {
                echo 'Iniciando análisis de código en SonarQube...'
                // 'Sonar' debe ser el nombre que pusiste en Administrar Jenkins > System > SonarQube servers
                withSonarQubeEnv('Sonar') {
                    sh '''
                    docker run --rm \
                    --network sistema-jenkins_devops-net \
                    -e SONAR_HOST_URL="http://sonarqube:9000" \
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
                // Levantamos la aplicación usando el docker-compose.yml de tu repositorio
                sh 'docker compose up -d --build'
            }
        }
    }

    post {
        success {
            echo '¡Pipeline finalizado con éxito!'
        }
        failure {
            echo 'El Pipeline ha fallado. Revisa los logs de la etapa correspondiente.'
        }
    }
}
