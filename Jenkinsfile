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
	    
	   stage('Build Docker Image ') {
            steps {
                sh " sudo docker build  -t ${dockerImage} ."
            }
        }

        stage('Docker Run') {
            steps {
                sh " sudo docker run -dit --name ${dockerContainerName}  ${dockerImage}"
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([string(credentialsId: 'Dockerhub-key', variable: 'dockerPWD')]) {
                    sh "sudo docker login -u ashagari -p ${dockerPWD}"
                }
                sh "sudo docker push ${dockerImage}"
            }
        }


    }
}
