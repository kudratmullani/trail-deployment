pipeline {
    agent any

    parameters {
        choice(
            name: 'ACTION',
            choices: ['provision', 'deprovision'],
            description: 'Choose whether to provision or deprovision EC2 instance'
        )
    }
    
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

        stage('Provision VM') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    script{
                        if (params.ACTION == "provision") {
                            sh '''
                                cd Terraform/
                                terraform init
                                terraform plan
                                terraform apply -auto-approve
                            '''
                        } 
                    }          
                }
            }
        }
        stage('Deprovision VM') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    script {
                        if (params.ACTION == "deprovision") {
                            sh '''
                                cd Terraform/
                                terraform destroy -auto-approve
                            '''
                        }   
                    }
                           
                }
            }
        }
    }
}
