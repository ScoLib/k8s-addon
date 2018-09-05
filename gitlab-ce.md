# Helm 安装 GitLab CE

## 配置参数

[gitlab-ce.yaml](./files/gitlab-ce.yaml)

参数说明见： [https://gitlab.com/charts/gitlab/blob/master/doc/charts/README.md](https://gitlab.com/charts/gitlab/blob/master/doc/charts/README.md)



## 执行安装

```sh
helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm install --name gitlab -f ./files/gitlab-ce.yaml gitlab/gitlab
```



