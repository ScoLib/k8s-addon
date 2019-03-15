# NFS服务器以及 nfs-client-provisioner的部署



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

```sh
cat << EOF > ~/nfs-server.yaml
- hosts:
  - nfs-server
  roles:
  - geerlingguy.nfs
  vars:
    nfs_exports: [
        # /etc/exports 配置文件内容 如：
        "/data/nfs 172.168.1.0/24(rw,sync,insecure,no_subtree_check,no_root_squash)"
    ]
EOF
```



### 4 执行 Playbook

```sh
ansible-playbook ~/nfs-server.yaml
```



## nfs-client-provisioner

> 基于 helm 部署

### 配置参数

[nfs-client-provisioner.yaml](./files/nfs-client-provisioner.yaml) 参考文档  [stable/nfs-client-provisioner/README.md#configuration](https://github.com/helm/charts/blob/master/stable/nfs-client-provisioner/README.md#configuration)

- 修改 `image.repository`
- 开启 `storageClass.defaultClass`

> 注意： 需要手动指定 `nfs` 的 `server` 和 `path`



### 安装 provisioner

```sh
helm install --name nfs-client-provisioner -f ./files/nfs-client-provisioner.yaml --set nfs.server=x.x.x.x --set nfs.path=/exported/path stable/nfs-client-provisioner
```

