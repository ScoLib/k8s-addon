# Helm 安装 NGINX Ingress

## 配置参数

[nginx-ingress.yaml](./files/nginx-ingress.yaml) 参考文档 [stable/nginx-ingress/README.md#configuration ](https://github.com/helm/charts/blob/master/stable/nginx-ingress/README.md#configuration)

- 替换 `controller` 和 `default-backend`  镜像
- ~~指定 `service.type`  为  `NodePort`，以及 `service.nodePorts` 为 `32080`/ `32443`~~
- 指定 `controller.service.type`  为  `ClusterIP`




## 执行

```sh
# V2
helm install --name nginx-ingress --namespace ingress -f ./files/nginx-ingress.yaml  --set controller.service.clusterIP=x.x.x.x stable/nginx-ingress

# V3
kubectl create namespace ingress
helm install nginx-ingress --namespace ingress -f ./files/nginx-ingress.yaml  --set controller.service.clusterIP=x.x.x.x stable/nginx-ingress
```

