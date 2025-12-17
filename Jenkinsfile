pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/yassinebh3/Devops.git'
            }
        }
        stage('Build JAR') {
            steps {
                sh '''
                    if [ -f "mvnw" ]; then
                        chmod +x mvnw
                        ./mvnw clean package -DskipTests
                    else
                        mvn clean package -DskipTests
                    fi
                '''
            }
        }
        stage('Build Docker Image') {
            steps {
                sh '''
                    echo "=== Construction de l'image Docker ==="
                    docker build -t student-management:latest .
                    echo "=== Image construite avec succès ==="
                    docker images student-management:latest
                '''
            }
        }
    }
    post {
        always {
            echo "Pipeline terminé"
            sh '''
                echo "Artefacts :"
                ls -lh target/*.jar || echo "Pas de JAR"
                echo "Images Docker :"
                docker images student-management || echo "Pas d'image"
            '''
        }
        success {
            echo "🎉 Build et image Docker réussis !"
            archiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: true
        }
        failure {
            echo "😞 Échec du pipeline"
        }
    }
}
