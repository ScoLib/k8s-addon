# Helm 安装 NGINX Ingress

## 配置参数

[nginx-ingress.yaml](./files/nginx-ingress.yaml)

参数说明见：[stable/nginx-ingress/README.md#configuration](https://github.com/helm/charts/blob/master/stable/nginx-ingress/README.md#configuration)



## 执行

```sh
helms install --name nginx-ingress -f ./files/nginx-ingress.yaml stable/nginx-ingress
```

