pipeline {
    agent any
    stages {
        stage('1. SonarQube Analysis') {
            steps {
                script {
                    // Esto descarga el scanner dentro de Jenkins (donde están tus archivos)
                    def scannerHome = tool 'SonarQube Scanner'
                    
                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=mi-proyecto-python \
                        -Dsonar.sources=. \
                        -Dsonar.python.version=3 \
                        -Dsonar.host.url=http://sonarqube:9000"
                    }
                }
            }
        }

        stage('2. Build Image') {
            steps {
                // Añadimos --no-cache para asegurar que se construye con los últimos cambios de código
                sh 'docker build --no-cache -t fase1:latest .'
            }
        }

        stage('3. Run Container') {
            steps {
                sh 'docker rm -f test-container || true'
                sh 'docker run --name test-container -p 5000:5000 -d fase1:latest'
            }
        }
    }
}
