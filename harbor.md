# Helm 安装 Harbor

## 配置参数

参考文档 [goharbor/harbor-helm/blob/master/README.md#configuration](https://github.com/goharbor/harbor-helm/blob/master/README.md#configuration) 




## 执行安装

```sh

# 添加仓库
helm repo add harbor https://helm.goharbor.io

# 创建 Namespace
kubectl create namespace harbor
# 创建Ingress TLS secret 必须是颁发给 `expose.ingress.hosts` 的
kubectl create secret tls harbor-ingress-tls -n harbor --key ~/ssl/tls.key --cert ~/ssl/tls.crt


# V3
helm install harbor \
	-n harbor \
	--set expose.tls.secretName=harbor-ingress-tls \
	--set expose.ingress.hosts.core=core.harbor.k8s.lo \
	--set expose.ingress.hosts.notary=notary.harbor.k8s.lo \
	--set externalURL=https://core.harbor.k8s.lo \
	harbor/harbor

```



## 访问

```
https://core.harbor.k8s.lo

admin
Harbor12345
```

