# Helm 安装 GitLab CE

## 配置参数

[gitlab-ce.yaml](./files/gitlab-ce.yaml) 参考文档 [https://gitlab.com/charts/gitlab/blob/master/doc/charts/README.md](https://gitlab.com/charts/gitlab/blob/master/doc/charts/README.md)

- 替换所有镜像
- 指定 `global.hosts.domain` `global.ingress.tls.secretName`
- 关闭 `global.hosts.https` `global.ingress.configureCertmanager`
- 关闭安装 `certmanager` `nginx-ingress` `prometheus` 
- 禁用 s3 缓存  `gitlab-runner.runners.cache`
- 分配资源 `gitlab.unicorn.resources`



注： 因为关闭了 `certmanager` ，所以需要指定 `global.ingress.tls.secretName` 

### 手动创建secret：

```sh
kubectl create secret tls gitlab-wildcard-tls --cert=<path/to-full-chain.crt> --key=<path/to.key>
```

该证书和key必须是办法给 `global.hosts.domain` 的



## 执行安装

```sh
helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm install --name gitlab -f ./files/gitlab-ce.yaml --namespace gitlab gitlab/gitlab 
```



