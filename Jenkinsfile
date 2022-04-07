pipeline {
  agent any
  environment {
    registry = '$ecr-registry'
  }

  stages {
    stage("Build image") {
      steps {
        script {
          sh 'docker image prune -a -f'
          dockerImage = docker.build registry + ":shipSafe-v1.0"
        }
      }
    }

    stage("Upload image to registry") {
      steps("Authenticate registry") {
        script {
          sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin ecr-registry'
          sh 'docker push $registry'
        }
      }
    }

    stage('stop previous containers') {
      steps {
        sh 'docker ps -f name=shipSafe -q | xargs --no-run-if-empty docker container stop'
        sh 'docker container ls -a -fname=shipSafe -q | xargs -r docker container rm'
      }
    }
      
    stage('Docker Run') {
      steps{
        script {
          sh 'docker run -d -p 80:3000 --rm --name shipSafe $registry'
        }
      }
    }
  }
}