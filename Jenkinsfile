pipeline {
  agent any
  
  stages {
    stage("Install app dependencies") {
      steps {
        script {
            sh "npm install"
        }
      }
    }       
    stage("Build app") {
      steps {
        script {
            sh "npm run build"
        }
      }
    }  
    stage("Deploy build") {
      steps {
        script {
            sh "cp -R components app/components"        
        }
      }
    }    
  }
}