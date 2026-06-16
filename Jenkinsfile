pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh './gradlew build -x test'
            }
        }

        stage('Docker - Start omgeving') {
            steps {
                sh 'cd Docker && docker-compose down -v || true'
                sh 'cd Docker && docker-compose up -d --build'
                sh '''
                    echo "Wachten tot app klaar is..."
                    for i in $(seq 1 30); do
                        STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://host.docker.internal:9090/api/products 2>/dev/null || echo "000")
                        echo "Poging $i/30 - HTTP status: $STATUS"
                        if [ "$STATUS" = "200" ] || [ "$STATUS" = "404" ]; then
                            echo "App is klaar!"
                            break
                        fi
                        sleep 3
                    done
                '''
            }
        }

        stage('Acceptatietesten - Newman') {
            steps {
                sh 'newman run "Tests/thesis collection.postman_collection.json" --env-var "baseUrl=http://host.docker.internal:9090"'
            }
        }

        stage('Docker - Stop omgeving') {
            steps {
                sh 'cd Docker && docker-compose down -v || true'
            }
        }
    }

    post {
        always {
            echo 'Pipeline klaar!'
        }
        success {
            echo 'Alle testen geslaagd!'
        }
        failure {
            echo 'Er zijn fouten gevonden!'
        }
    }
}
