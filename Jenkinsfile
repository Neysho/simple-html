pipeline {
    agent {
    kubernetes {
      yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: kubectl
    image: gcr.io/cloud-builders/kubectl
    imagePullPolicy: IfNotPresent
    command: ["cat"]
    tty: true
  - name: docker
    image: docker:latest
    command:
    - cat
    tty: true
    volumeMounts:
    - mountPath: /var/run/docker.sock
      name: docker-sock
  volumes:
  - name: docker-sock
    hostPath:
      path: /var/run/docker.sock      
      '''
      }
    }
    // tools {
    //     nodejs "node-14.21.3"
    // }
    environment{
        DOCKERHUB_CREDENTIALS=credentials('docker-hub-neysho')
    }

    stages{
            stage('Checkout'){
                steps{
                    container('docker') {
                    // deleteDir()
                     checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-neysho', url: 'https://github.com/Neysho/simple-html.git']])
                       sh ''' cd blue
                              ls
                              docker build -t neysho/web-app-blue:1 .
                              echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                              docker push neysho/web-app-blue:1
                       '''
               }
              }
            }

            
            stage('Kubernetes here') {
                steps {
                    container('kubectl') {
                     withKubeConfig([credentialsId: 'kube-config', serverUrl: 'https://192.168.1.130:6443']) {
                     sh 'kubectl delete pods -n web-app -l app=web-app-blue'
                  }
                  }
                }
            }
    }
  }
