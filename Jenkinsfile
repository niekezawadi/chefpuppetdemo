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
                sh 'newman run "Tests/thesis collection.postman_collection.json" --env-var "baseUrl=http://host.docker.internal:9090"'
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