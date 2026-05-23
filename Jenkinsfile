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
                sh 'sleep 15'
            }
        }

        stage('Acceptatietesten - Newman') {
            steps {
                sh '''
                    APP_IP=$(docker inspect -f "{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}" docker-app-1)
                    newman run "Tests/thesis collection.postman_collection.json" --env-var "baseUrl=http://$APP_IP:8080"
                '''
            }
        }

        stage('Docker - Stop omgeving') {
            steps {
                sh 'cd Docker && docker-compose down -v'
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