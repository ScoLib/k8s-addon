# Helm 安装 GitLab CE

## 配置参数

[gitlab-ce.yaml](./files/gitlab-ce.yaml) 参考文档 [https://gitlab.com/charts/gitlab/blob/master/doc/charts/README.md](https://gitlab.com/charts/gitlab/blob/master/doc/charts/README.md)

- 替换所有镜像
- 指定 `global.imagePullPolicy` 为 `Always`
- 指定 `global.hosts.domain` `global.ingress.tls.secretName`
- 指定 `global.ingress.class` 
- 关闭 `global.hosts.https` `global.ingress.configureCertmanager`
- 关闭安装 `certmanager` `nginx-ingress` `prometheus`  `gitlab-runner`
- 分配资源 `gitlab.unicorn.resources`



注： 因为关闭了 `certmanager` ，所以需要指定 `global.ingress.tls.secretName` 

### 手动创建secret：

```sh
kubectl create secret tls gitlab-wildcard-tls --cert=<path/to-full-chain.crt> --key=<path/to.key> -n gitlab
```

该证书和key必须是办法给 `global.hosts.domain` 的



如果 `namspace` `gitlab` 不存在，则需要先创建 

```sh
kubectl create namespace gitlab
```



## 执行安装

```sh
helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm install --name gitlab -f ./files/gitlab-ce.yaml --namespace gitlab gitlab/gitlab 
```



## 关于 `gitlab-runner`

> 如果 `global.hosts.domain` 使用的是公网域名，则可以忽略以下内容，并开启安装 `gitlab-runner`

由于 `global.hosts.domain` 指定的是本地域名，如果开启安装 `gitlab-runner` 会出现pod里无法请求 `gitlab` 的错误 

```sh
ERROR: Registering runner... failed                 runner=023KfPaP status=couldn't execute POST against https://gitlab.k8s.lo/api/v4/runners: Post https://gitlab.k8s.lo/api/v4/runners: x509: certificate signed by unknown authority
PANIC: Failed to register this runner. Perhaps you are having network problems
```

可以执行以下 `sh`  手动安装 `gitlab-runner`

```sh
helm install --name gitlab-runner --namespace gitlab gitlab/gitlab-runner --set gitlabUrl=http://gitlab-unicorn.gitlab.svc.cluster.local:8181/,runnerRegistrationToken=<registration token>,rbac.create=true 
```

`runnerRegistrationToken` 需登录 `gitlab` `Admin Area` 查看具体值
