stage('2. SonarQube Analysis') {
            steps {
                withSonarQubeEnv('Sonar') {
                    // Usamos la red sistema-jenkins_devops-net para que el scanner vea a SonarQube
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
