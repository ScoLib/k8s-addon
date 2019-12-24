# Helm 安装 Kubernetes Dashboard

## 配置参数

[kubernetes-dashboard.yaml](./files/kubernetes-dashboard.yaml) 参考文档 [stable/kubernetes-dashboard/README.md#configuration](https://github.com/helm/charts/blob/master/stable/kubernetes-dashboard/README.md#configuration)

- 替换镜像

- ~~`extraArgs` 增加参数 `token-ttl=1800`~~

- 指定 `tolerations` 

  ```
    # 不调度master节点
    - key: node-role.kubernetes.io/master
      effect: NoSchedule
  ```

  

- 开启 `ingress`

- 指定 `ingress.hosts`

- 指定 `ingress.tls`

  ```
    tls:
      - secretName: kubernetes-dashboard-tls
        hosts:
          - dashboard.k8s.lo
  ```

  

- 指定 `ingress.annotations`

  ```
  kubernetes.io/ingress.class: nginx
  nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
  ```

- 开启 `rbac.clusterAdminRole`



## 执行

```sh
mkdir ~/ssl
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout ~/ssl/tls.key -out ~/ssl/tls.crt -subj "/CN=*.k8s.lo"
# 生成tls证书secret
kubectl create secret tls kubernetes-dashboard-tls -n kube-system --key ~/ssl/tls.key --cert ~/ssl/tls.crt

# 查看
kubectl get secret -n kube-system |grep dashboard

# V2
helm install --name kubernetes-dashboard --namespace kube-system -f ./files/kubernetes-dashboard.yaml stable/kubernetes-dashboard 

# V3
helm install kubernetes-dashboard --namespace kube-system -f ./files/kubernetes-dashboard.yaml stable/kubernetes-dashboard 

# 查看
kubectl get pods -n kube-system -o wide

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



