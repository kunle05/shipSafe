pipeline {
  agent any
  environment {
    registry = "904941000330.dkr.ecr.us-east-2.amazonaws.com/kkodes-apps:v1.0"
  }

  stages {
    stage("Build image") {
      steps {
        script {
          dockerImage = docker.build registry
        }
      }
    }

    stage("Upload image to registry") {
      steps("Authenticate registry") {
        script {
          sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 904941000330.dkr.ecr.us-east-2.amazonaws.com'
          sh 'docker push 904941000330.dkr.ecr.us-east-2.amazonaws.com/kkodes-apps:v1.0'
        }
      }
    }
  }
}