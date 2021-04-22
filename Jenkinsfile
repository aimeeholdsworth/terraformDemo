pipeline {
    agent any
    environment {
        MYSQL_ROOT_PASSWORD = credentials("MYSQL_ROOT_PASSWORD")
        DOCKER_PASSWORD = credentials("DOCKER_PASSWORD")
    }
    stages {

        
        // stage("Install Dependencies"){
        //     steps {
        //         sh "bash install-dependencies.sh"
        //     }
        // }
        
        stage("Build"){
            steps {
                sh '''
                    sudo systemctl disable nginx
		            export DATABASE_URI=${DATABASE_URI}
		            
                    export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
                    
                    mysql -h ${USER_DB_ENDPOINT} -P 3306 -u ${USERNAME} -p${MYSQL_ROOT_PASSWORD} < Create.sql
                    mysql -h ${TEST_DB_ENDPOINT} -P 3306 -u ${USERNAME} -p${MYSQL_ROOT_PASSWORD} < Create.sql
                    cd ..
		            sudo docker-compose up -d --build
		            sudo curl localhost:80
            }
        }
        stage("Push"){
            steps {
                sh "docker-compose push"
            }
        }
        stage("Deploy"){
            steps {
                sh "docker-compose up -d"
            }
        }
    }
}