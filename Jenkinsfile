pipeline {
    agent any
    stages {
        stage('1. SonarQube Analysis') {
            steps {
                script {
                    // Carga la herramienta configurada en Jenkins
                    def scannerHome = tool 'SonarQube Scanner'
                    
                    withSonarQubeEnv('SonarQube') {
                        // Realiza el análisis pero no se detiene a esperar el resultado
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
                // Construye la imagen de Docker
                sh 'docker build -t fase1:latest .'
            }
        }

        stage('3. Run Container') {
            steps {
                // Limpia contenedores viejos y levanta el nuevo
                sh 'docker rm -f test-container || true'
                sh 'docker run --name test-container -p 5000:5000 -d fase1:latest'
            }
        }
    }
}
