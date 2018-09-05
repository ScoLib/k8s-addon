# NFS服务器以及 nfs-client-provisioner的部署



## 前提

- 安装 ansible
- 安装 helm



## NFS服务器

> 基于ansible 部署

### 1 安装 nfs role

```sh
ansible-galaxy install geerlingguy.nfs	
```

安装成功后，role文件将会保存到 `/etc/ansible/roles/geerlingguy.nfs`

### 2 配置inventory 

> 一般是 `/etc/ansible/hosts` 文件

```ini
[nfs-server]
# ip或hostname
172.168.1.100
```

### 3 编辑 Playbook 文件

见： [nfs-server.yaml](./files/nfs/nfs-server.yaml)



### 4 执行 Playbook

```sh
ansible-playbook ./files/nfs/nfs-server.yaml
```



##nfs-client-provisioner

> 基于 helm 部署

### 配置参数

见：  [nfs-client-provisioner.yaml](./files/nfs/nfs-client-provisioner.yaml)

参数说明见： [https://github.com/helm/charts/blob/master/stable/nfs-client-provisioner/README.md](https://github.com/helm/charts/blob/master/stable/nfs-client-provisioner/README.md)

### 安装 provisioner

```sh
helm install --name nfs-client-provisioner -f ./files/nfs/nfs-client-provisioner.yaml stable/nfs-client-provisioner
```

