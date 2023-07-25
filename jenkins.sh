    pipeline {
        agent none

        environment {
            PATH = "/usr/bin:${env.PATH}"
        }

        stages {
            stage('Clone Repository') {
                agent { label 'jenkins' } // Use the 'jenkins' node for this stage
                steps {
                    // Clone the repository using Git
                    git url: 'https://github.com/7Vanessa/DevOps_Project', branch: 'master'
                }
            }

            stage('Build Static Website') {
                agent { label 'jenkins' } // Use the 'jenkins' node for this stage
                steps {
                    // Build the static website
                    dir('./') {
                        sh 'npm install'
                        sh 'npm run build'
                    }
                }
            }

            stage('Launch Server') {
                agent { label 'slave1' } // Use the 'slave1' node for this stage
                steps {
                    // Launch the server
                    dir('./') {
                        sh 'node server.js &'
                    }
                }
            }

            stage('Try to reach server') {
                agent { label 'slave2' } // Use the 'slave2' node for this stage
                steps {
                    // Verify the application launch by sending a request to the server
                    sh 'sleep 20' // Wait for 20 seconds to allow more time for the server to start
                    sh 'curl --connect-timeout 10 http://localhost:3000' // Send a request to the server with a timeout
                }
            }
        }

        post {
            always {
                // Stop the server after the pipeline is finished
                sh 'pkill -f "node server.js"'
            }
            success {
                sh "echo 'Jenkins pipeline build succeeded!'"
                mail to: 'sabrina.mohammedi@efrei.net',
                     subject: 'Build réussi : Mon projet Jenkins',
                     body: 'La construction du projet Jenkins a réussi. Félicitations !'
            }
            failure {
                sh "echo 'Jenkins pipeline build failed!'"
                mail to: 'sabrina.mohammedi@efrei.net',
                     subject: 'Échec de la construction : Mon projet Jenkins',
                     body: 'La construction du projet Jenkins a échoué. Veuillez vérifier le pipeline.'
            }
        }
    }
