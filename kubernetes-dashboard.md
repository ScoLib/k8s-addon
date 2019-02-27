# Helm 安装 Kubernetes Dashboard

## 配置参数

[kubernetes-dashboard.yaml](./files/kubernetes-dashboard.yaml) 参考文档 [stable/kubernetes-dashboard/README.md#configuration](https://github.com/helm/charts/blob/master/stable/kubernetes-dashboard/README.md#configuration)

- 替换镜像
- `extraArgs` 增加参数 `token-ttl=1800`
- 指定 `tolerations` 
- 开启 `ingress`
- 指定 `ingress.hosts`、 `ingress.annotations`
- 开启 `rbac.clusterAdminRole`



## 执行

```sh
# 生成tls证书secret
kubectl create secret tls kubernetes-dashboard-tls -n kube-system --key ./tls.key --cert ./tls.crt
helm install --name kubernetes-dashboard --namespace kube-system -f ./files/kubernetes-dashboard.yaml stable/kubernetes-dashboard 
# 创建可读可写 admin Service Account
cat << EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system

EOF
# 获取 Bearer Token，找到输出中 ‘token:’ 开头那一行
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
```



