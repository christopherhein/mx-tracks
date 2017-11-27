node {
  stage 'Checkout'
  git 'https://github.com/christopherhein/mx-tracks.git'

  stage 'Build Dockerfile'
  docker.build('christopherhein/${JOB_NAME}')

  stage 'Push to Docker Hub'
  docker.image('christopherhein/${JOB_NAME}').push('${BUILD_NUMBER}')

  stage 'update k8s config'
  sh 'sed -i 's/BUILD_TAG/${BUILD_NUMBER}/g' configs/app.yml'

  stage 'deploy k8s config'
  node {
    docker.image('omarlari/alpine-kubectl').inside("--volume=/home/core/.kube:/config/.kube") {
      sh 'kubectl apply -f configs/'
    }
  }
}
