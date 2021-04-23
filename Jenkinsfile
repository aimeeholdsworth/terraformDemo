pipeline {
    agent any
    environment {
        MYSQL_ROOT_PASSWORD = credentials("MYSQL_ROOT_PASSWORD")
        DOCKER_PASSWORD = credentials("DOCKER_PASSWORD")
        // DATABASE_URI = credentials("DATABASE_URI")
        // TEST_DATABASE_URI = credentials("TEST_DATABASE_URI")
        SECRET_KEY = credentials("SECRET_KEY")
    }
    stages {

        
        stage("Test FRont"){
            steps {
                sh '''
                        docker ps --all
                        docker-compose up -d
                        cd ./frontend
                        
                        pytest
                '''
            }
        }

         stage("Test Back"){
            steps {
                sh '''
                        docker ps --all
                        docker-compose up -d
                        cd ./backend
                        
                        pytest
                '''
            }
        }
        
        stage("Deploy"){
            steps {
                sh '''    
                        docker ps --all          
                        ssh '35.176.101.41' -oStrictHostKeyChecking=no << EOF
                                                                        git clone 'https://github.com/aimeeholdsworth/terraformDemo.git'
                                                                        cd ./module_setup
                                                                        docker compose up
                                                                        EOF
                '''                                                    
            }
        }
        
    }
}