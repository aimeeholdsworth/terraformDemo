pipeline {
    agent any
    environment {
        MYSQL_ROOT_PASSWORD = credentials("MYSQL_ROOT_PASSWORD")
        DOCKER_PASSWORD = credentials("DOCKER_PASSWORD")
    }
    stages {

        
        stage("Test"){
            steps {
                docker compose up
                pytest
            }
        }
        
        stage("Deploy"){
            steps {
                
                ssh 35.176.101.41 -oStrictHostKeyChecking=no << EOF
                git clone 'https://github.com/aimeeholdsworth/terraformDemo.git'
                cd ./module_setup
                docker compose up
                EOF
            }
        }
        
    }
}