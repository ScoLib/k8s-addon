# Helm 安装 GitLab CE

## 配置参数

[gitlab.yaml](./files/gitlab.yaml) 参考文档 [https://gitlab.com/charts/gitlab/blob/master/doc/charts/globals.md](https://gitlab.com/charts/gitlab/blob/master/doc/charts/globals.md)

- 替换所有镜像
- 指定 `global.edition` 为 `ce`
- 指定 `global.hosts.domain` 
- 关闭 `global.ingress.configureCertmanager`
- 指定 `global.ingress.class`  `global.ingress.tls.secretName`
- 关闭安装 `certmanager` `nginx-ingress` `prometheus` 
- 禁用 s3 缓存  `gitlab-runner.runners.cache`
- 指定 `gtlab-runner.certsSecretName` 
- 分配资源 `gitlab.unicorn.resources`



### 创建 `namspace` `gitlab`  

```sh
kubectl create namespace gitlab
```

### 创建Ingress TLS secret：

```sh
kubectl create secret tls gitlab-ingress-tls --cert=<path/tls.crt> --key=<path/tls.key> -n gitlab
```

该证书和key必须是颁发给 `global.hosts.domain` 的

### GitLab Runner 关联的gitlab证书 secret

see: https://docs.gitlab.com/ee/install/kubernetes/gitlab_runner_chart.html#providing-a-custom-certificate-for-accessing-gitlab

```sh
kubectl -n gitlab create secret generic gitlab-runner-certs-secret --from-file=gitlab.k8s.lo.crt=<path/tls.crt>  --from-file=registry.k8s.lo.crt=<path/tls.crt> --from-file=minio.k8s.lo.crt=<path/tls.crt>
```



## 执行安装

```sh
helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm install --name gitlab -f ./files/gitlab-ce.yaml --namespace gitlab gitlab/gitlab 
```



