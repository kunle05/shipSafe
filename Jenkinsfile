pipeline {
  agent any
  environment {
    registry = "904941000330.dkr.ecr.us-east-2.amazonaws.com/kkodes-apps:shipSafe-v1.0"
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
          sh 'docker push 904941000330.dkr.ecr.us-east-2.amazonaws.com/kkodes-apps:shipSafe-v1.0'
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
                sh 'docker run -d -p 3000:3000 --rm --name shipSafe 904941000330.dkr.ecr.us-east-2.amazonaws.com/kkodes-apps:shipSafe-v1.0'
            }
      }
  }
}