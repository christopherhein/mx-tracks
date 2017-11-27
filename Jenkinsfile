node {
  def container
  stage('Checkout') {
    checkout scm
  }

  stage('Build Container') {
    container = docker.build('christopherhein/mx-tracks')
  }

  stage('Push Container') {
    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
      container.push("${BUILD_NUMBER}")
      container.push("latest")
    }
  }

  stage('Update k8s Config') {
    sh "sed -i 's/VERSION_NUMBER/${BUILD_NUMBER}/g' configs/app.yml"
  }

  stage('Deploy k8s config') {
    sh 'kubectl apply -f configs/'
  }
}
