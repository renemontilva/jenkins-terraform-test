pipeline {
    agent none

    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = credentials('AWS_DEFAULT_REGION')
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
                sh '''
                    terraform plan -no-color -out=plan_${BUILD_TAG}.tfplan
                '''
            }
            post {
                success {
                    archiveArtifacts artifacts: '**/*.out', fingerprint: true, followSymlinks: false, onlyIfSuccessful: true
                }
            }
        }
        stage("Cost Estimation") {
            
            agent {
                label 'linux'
            }
                
            steps {
                sh "echo 'Estimating costs...' "
            }
        }
        stage("Policy Check") {
            agent {
                label 'linux'
            }
 
            steps {
                sh "echo 'Checking policies ....'"
            }
        }
        stage("Apply") {
            agent {
                docker {
                    image 'hashicorp/terraform'
                    args '--entrypoint='                    
                }
            }
 
            steps {
                sh "terraform apply -auto-approve plan_${BUILD_TAG}.tfplan"
            }
        }

    }

}