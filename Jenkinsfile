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

    stage("Deploy to K8S") {
      steps {
        script {
          withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'kkodes-k8-config', namespace: '', serverUrl: '') {
            sh 'kubectl apply -f kube-config.yml'
          }
        }
      }
    }
      
    // stage('Docker Run') {
    //   steps{
    //     script {
    //       // sh 'docker run -d -p 80:3000 --rm --name shipSafe $registry'
    //     }
    //   }
    // }
    
    stage('Remove Unused docker images') {
      steps {
        sh 'docker image prune -a -f'
      }
    }
  }
}