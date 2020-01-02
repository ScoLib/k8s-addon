#!/bin/bash

set -o nounset
set -o errexit

down_gitlab_image() {

  gitlabVer=v12.6.1
  gitlabRunnerVer=alpine-${gitlabVer}
  gitlabShellVer=v10.3.0
  kubectlVer=1.13.12
  exporterVer=5.1.0
  certificatesVer=20171114-r3

  imageDir=/etc/ansible/down
  
  [[ -d "$imageDir" ]] || { echo "[ERROR] $imageDir not existed!"; exit 1; }


  if [[ ! -f "$imageDir/gitlab_ee_$gitlabVer.tar" ]];then
    docker pull registry.gitlab.com/gitlab-org/build/cng/gitlab-unicorn-ee:${gitlabVer} && \
    docker pull registry.gitlab.com/gitlab-org/build/cng/gitlab-task-runner-ee:${gitlabVer} && \
    docker pull registry.gitlab.com/gitlab-org/build/cng/gitlab-sidekiq-ee:${gitlabVer} && \
    docker pull registry.gitlab.com/gitlab-org/build/cng/gitlab-workhorse-ee:${gitlabVer} && \
    docker pull registry.gitlab.com/gitlab-org/build/cng/gitlab-rails-ee:${gitlabVer} && \
    docker save -o ${imageDir}/gitlab_ee_${gitlabVer}.tar registry.gitlab.com/gitlab-org/build/cng/gitlab-unicorn-ee:${gitlabVer} registry.gitlab.com/gitlab-org/build/cng/gitlab-task-runner-ee:${gitlabVer} registry.gitlab.com/gitlab-org/build/cng/gitlab-sidekiq-ee:${gitlabVer} registry.gitlab.com/gitlab-org/build/cng/gitlab-workhorse-ee:${gitlabVer} registry.gitlab.com/gitlab-org/build/cng/gitlab-rails-ee:${gitlabVer}
  fi
  if [[ ! -f "$imageDir/gitlab_shell_$gitlabShellVer.tar" ]];then
    docker pull registry.gitlab.com/gitlab-org/build/cng/gitlab-shell:${gitlabShellVer} && \
    docker save -o ${imageDir}/gitlab_shell_${gitlabShellVer}.tar registry.gitlab.com/gitlab-org/build/cng/gitlab-shell:${gitlabShellVer}
  fi

  if [[ ! -f "$imageDir/gitlab_gitaly_latest.tar" ]];then
    docker pull registry.gitlab.com/gitlab-org/build/cng/gitaly:latest && \
    docker save -o ${imageDir}/gitlab_gitaly_latest.tar registry.gitlab.com/gitlab-org/build/cng/gitaly:latest
  fi

  if [[ ! -f "$imageDir/gitlab_kubectl_$kubectlVer.tar" ]];then
    docker pull registry.gitlab.com/gitlab-org/build/cng/kubectl:${kubectlVer} && \
    docker save -o ${imageDir}/gitlab_kubectl_${kubectlVer}.tar registry.gitlab.com/gitlab-org/build/cng/kubectl:${kubectlVer}
  fi

  if [[ ! -f "$imageDir/gitlab_exporter_$exporterVer.tar" ]];then
    docker pull registry.gitlab.com/gitlab-org/build/cng/gitlab-exporter:${exporterVer} && \
    docker save -o ${imageDir}/gitlab_exporter_${exporterVer}.tar registry.gitlab.com/gitlab-org/build/cng/gitlab-exporter:${exporterVer}
  fi

  if [[ ! -f "$imageDir/gitlab_certificates_${certificatesVer}.tar" ]];then
    docker pull registry.gitlab.com/gitlab-org/build/cng/alpine-certificates:${certificatesVer} && \
    docker save -o ${imageDir}/gitlab_certificates_${certificatesVer}.tar registry.gitlab.com/gitlab-org/build/cng/alpine-certificates:${certificatesVer}
  fi


  if [[ ! -f "$imageDir/gitlab_runner_${gitlabRunnerVer}.tar" ]];then
    docker pull gitlab/gitlab-runner:${gitlabRunnerVer} && \
    docker save -o ${imageDir}/gitlab_runner_${gitlabRunnerVer}.tar gitlab/gitlab-runner:${gitlabRunnerVer}
  fi

}

ACTION=down_gitlab_image


# excute cmd "$ACTION" 
echo -e "[INFO] \033[33mAction begin\033[0m : $ACTION"
${ACTION} || { echo -e "[ERROR] \033[31mAction failed\033[0m : $ACTION"; return 1; }
echo -e "[INFO] \033[32mAction successed\033[0m : ${ACTION}"


                    