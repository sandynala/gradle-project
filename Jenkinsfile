pipeline {
	agent any

       tools {
        jdk 'JDK 1.11.*'
		gradle 'gradle'
                
	}	
	
      environment {
		 dockerImage = "ashagari/javaapp_$JOB_NAME:$BUILD_NUMBER"
         dockerContainerName = 'javaapp_$JOB_NAME_$BUILD_NUMBER'		
	}
	
    stages {
	    stage('Scm Checkout') {
		    steps {
			    checkout scm
		    }
	    }
	    
	    stage('Build') {
		    steps {
			    sh 'gradle init'
                sh 'gradle build'
		    }
	    }
	    
	    stage('Test') {
		    steps {
			    echo "Testing..."
			    sh 'gradle test'
		    }
	    }
	    
	   stage('Build Docker Image ') {
            steps {
                sh "docker build  -t ${dockerImage} ."
            }
        }

        stage('Docker Run') {
            steps {
                sh "docker run -dit --name ${dockerContainerName}  ${dockerImage}"
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([string(credentialsId: 'Dockerhub-key', variable: 'dockerPWD')]) {
                    sh "docker login -u ashagari -p ${dockerPWD}"
                }
                sh "docker push ${dockerImage}"
            }
        }


    }
}
