# Helm 安装 Jenkins

## 配置

[jenkins.yaml](./files/jenkins.yaml) 参考  [stable/jenkins/README.md#configuration](https://github.com/helm/charts/blob/master/stable/jenkins/README.md#configuration) 做以下调整：

- 指定 `Master.AdminPassword` 值为 `admin`
- 指定 `Master.ServiceType` 为 `ClusterIP`
- 指定 `Master.HostName` 为 `jenkins.k8s.lo`
- 调整 `Master.JavaOpts`
- 增加插件 `gitlab`  (`Master.InstallPlugins`)   
- RBAC权限开启 (`rbac.install`)

## 执行安装



```sh
helm install --name jenkins -f ./files/jenkins.yaml stable/jenkins
```

