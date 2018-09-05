# Helm 安装 Harbor

## 配置参数

[harbor.yaml](./files/harbor.yaml) 参考 [官方文档](https://github.com/goharbor/harbor-helm/blob/master/README.md) 做以下调整

- 指定 `externalURL`
- 指定 `ingress.hosts` 并关闭 `ingress.tls`

## 执行安装



```sh
git clone https://github.com/goharbor/harbor-helm
cd harbor-helm
helm dependency update
cd ../
helm install --name harbor -f ./files/harbor.yaml ./harbor-helm
```

