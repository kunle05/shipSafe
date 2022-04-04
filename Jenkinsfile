pipeline {
  agent any

  stages {
    stage("Install app dependencies") {
      steps {
        sh "npm install"
      }
    }

    stage("Run code") {
      steps {
        sh "npm run dev"
      }
    }
  }
}