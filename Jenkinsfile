pipeline {
    agent none

    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }

    stages {
        stage("Init") {
            agent {
                docker {
                    image 'hashicorp/terraform'
                    args '--entrypoint='
                }
            }
            steps {
                sh "terraform init -no-color"
            }
        }
        stage("Format") {
            agent {
                docker {
                    image 'hashicorp/terraform'
                    args '--entrypoint='
                }
            }
            steps {
                sh "terraform fmt -recursive -no-color"
            }
        }
        stage("Validate") {
            agent {
                docker {
                    image 'hashicorp/terraform'
                    args '--entrypoint='
                }
            }
            steps {
                sh "terraform validate -no-color"
            }

        }
        stage("Vulnerability Scanning") {
            agent {
                docker {
                    image 'aquasec/tfsec-ci'
                    reuseNode true
                }
            }
            steps {
                sh "tfsec . --no-color"

            }
        }
        stage("Plan") {
            agent {
                docker {
                    image 'hashicorp/terraform'
                    args '--entrypoint='                    
                }
            }
            steps {
                sh "terraform plan -no-color"
            }
        }
        stage("Cost Estimation") {
            agent {
                label 'linux'
            }
                
            steps {
                sh "echo 'Estimating costs..."
            }
        }
        stage("Policy Check") {
            agent {
                label 'linux'
            }
 
            steps {
                sh "Checking policies ...."
            }
        }
        stage("Apply") {
            agent {
                label 'linux'
            }
 
            steps {
                sh "Applying..."
            }
        }

    }

}