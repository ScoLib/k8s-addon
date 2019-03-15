# Helm 安装 GitLab CE

## 配置参数

[gitlab.yaml](./files/gitlab.yaml) 参考文档 [https://gitlab.com/charts/gitlab/blob/master/doc/charts/globals.md](https://gitlab.com/charts/gitlab/blob/master/doc/charts/globals.md)

- 替换所有镜像
- 指定 `global.edition` 为 `ce`
- 指定 `global.hosts.domain`
- 关闭 `global.hosts.https`
- 指定 `global.ingress.class` 
- 关闭 `global.ingress.configureCertmanager`
- 关闭安装 `certmanager` `nginx-ingress` `prometheus`  
- 禁用 s3 缓存  `gitlab-runner.runners.cache`
- 指定 `gtlab-runner.certsSecretName` 


## 执行安装

```sh
helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm install --name gitlab -f ./files/gitlab-ce.yaml --namespace gitlab gitlab/gitlab 
```



