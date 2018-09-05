# Helm 安装 Harbor

## 配置参数

[harbor.yaml](./files/harbor.yaml) 参考文档 [goharbor/harbor-helm/blob/master/README.md](https://github.com/goharbor/harbor-helm/blob/master/README.md) 

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

