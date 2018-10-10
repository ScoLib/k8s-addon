# Helm 安装 Kubernetes Dashboard

## 配置参数

[kubernetes-dashboard.yaml](./files/kubernetes-dashboard.yaml) 参考文档 [stable/kubernetes-dashboard/README.md#configuration](https://github.com/helm/charts/blob/master/stable/kubernetes-dashboard/README.md#configuration)

- 替换镜像
- `extraArgs` 增加参数 `token-ttl=1800`
- 指定 `tolerations` 
- 开启 `ingress`
- 指定 `ingress.hosts`




## 执行

```sh
helm install --name kubernetes-dashboard -f ./files/kubernetes-dashboard.yaml stable/kubernetes-dashboard
```

