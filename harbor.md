# Helm 安装 Harbor

## 配置参数

[harbor.yaml](./files/harbor.yaml) 参考文档 [goharbor/harbor-helm/blob/master/README.md](https://github.com/goharbor/harbor-helm/blob/master/README.md) 

- 指定 `expose.tls.secretName`、`expose.ingress.hosts`
- - 指定 `externalURL`

### 创建 Namespace harbor

```sh
kubectl create namespace harbor
```

### 创建Ingress TLS secret：

```sh
kubectl create secret tls harbor-ingress-tls --cert=<path/tls.crt> --key=<path/tls.key> -n harbor
```

该证书和key必须是颁发给 `expose.ingress.hosts` 的


## 执行安装

```sh
cd ~
git clone https://github.com/goharbor/harbor-helm
helm install --name harbor -f ./k8s-addon/files/harbor.yaml --namespace harbor ./harbor-helm
```

