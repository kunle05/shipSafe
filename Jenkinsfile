pipeline {
    agent any

    stages {
      stage("Install apps dependencies") {
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
