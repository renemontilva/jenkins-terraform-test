pipeline {
    agent none

    stages {
        stage("Format") {
            agent {
                docker {
                    image 'hashicorp/terraform'
                    args '--entrypoint='
                }
            }
            steps {
                sh "terraform fmt -recursive"
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
                sh "terraform validate"
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
                sh "terraform plan --no-color"
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