pipeline {
    agent any

    stages {
        stage('Checkout from GitHub') {
            steps {
                // Replace with your repo URL
                git branch: 'main', url: 'https://github.com/kudratmullani/trail-deployment.git'
                script{
                  echo "Checkout success..!!"
                }
            }
        }

        stage('Print .txt file') {
            steps {
                script {
                    // Replace with your file name
                    def fileContent = readFile 'README.md'
                    echo "===== File Content ====="
                    echo fileContent
                    echo "========================"
                }
            }
        }
    }
}
