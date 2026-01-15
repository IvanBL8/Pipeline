pipeline {
    agent any
    stages {
        stage('1. SonarQube Analysis') {
            steps {
                // 'SonarQube' debe ser el nombre que pongas en Administrar Jenkins > System
                withSonarQubeEnv('SonarQube') {
                    sh """
                    docker run --rm \
                    --network sistema-jenkins_devops-net \
                    -e SONAR_HOST_URL="http://sonarqube:9000" \
                    -e SONAR_TOKEN="${SONAR_AUTH_TOKEN}" \
                    -v "${WORKSPACE}:/usr/src" \
                    sonarsource/sonar-scanner-cli \
                    -Dsonar.projectKey=mi-proyecto-python \
                    -Dsonar.sources=.
                    """
                }
            }
        }

        stage('2. Build Image') {
            steps {
                // Construimos la imagen con el nombre 'fase1' como pide tu nuevo archivo
                sh 'docker build -t fase1:latest .'
            }
        }

        stage('3. Run Container') {
            steps {
                // Borramos el contenedor anterior si existe y levantamos el nuevo
                sh 'docker rm -f test-container || true'
                sh 'docker run --name test-container -p 5000:5000 -d fase1:latest'
            }
        }
    }
}
