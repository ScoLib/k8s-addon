# Helm 安装 Harbor

## 配置参数

[harbor.yaml](./files/harbor.yaml)

参数说明见： [goharbor/harbor-helm/blob/master/README.md#configuration](https://github.com/goharbor/harbor-helm/blob/master/README.md#configuration)



## 执行安装



```sh
git clone https://github.com/goharbor/harbor-helm
cd harbor-helm
helm dependency update
cd ../
helm install --name harbor -f ./files/harbor.yaml ./harbor-helm
```

