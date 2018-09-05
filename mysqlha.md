# Helm 安装 MySQL HA



## 配置

[mysqlha.yaml](./files/mysqlha.yaml)

参数说明见： [incubator/mysqlha/README.md#configuration](https://github.com/helm/charts/blob/master/incubator/mysqlha/README.md#configuration)

## 执行安装



```sh
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
helms install --name mysqlha -f ./files/mysqlha.yaml incubator/mysqlha
```

