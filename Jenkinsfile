pipeline {
  stages {
    stage("Install app dependencies") {
      step {
        script {
            sh "npm install"
        }
      }
    }       
    stage("Build app") {
      step {
        script {
            sh "npm run build"
        }
      }
    }  
    stage("Deploy build") {
      step {
        script {
            sh "cp -R components app/components"        
        }
      }
    }    
  }
}