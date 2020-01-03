# Helm 安装 Prometheus

## 配置参数

[prometheus.yaml](./files/prometheus.yaml) 参考文档 [stable/prometheus/README.md#configuration ](https://github.com/helm/charts/blob/master/stable/prometheus/README.md#configuration)

- 开启 `alertmanager.ingress`

  ```yaml
  alertmanager:
    ingress:
      # 开启
      enabled: true
  
      # nginx-ingress
      annotations: 
        kubernetes.io/ingress.class: nginx
        
      # 域名
      hosts: 
        - alertmanager.k8s.lo
        
      # 证书
      tls: 
        - secretName: prometheus-ingress-tls
          hosts:
            - alertmanager.k8s.lo
  ```

  

- 开启`server.ingress`

  ```yaml
  server:
    ingress:
      # 开启
      enabled: true
  
      # nginx-ingress
      annotations: 
        kubernetes.io/ingress.class: nginx
  
      # 域名
      hosts: 
        - prometheus.k8s.lo
  
      # 证书
      tls: 
        - secretName: prometheus-ingress-tls
          hosts:
            - prometheus.k8s.lo
  ```

  

- 关闭`pushgateway`

- 指定 `kubeStateMetrics.image.repository`  

- 指定 `alertmanagerFiles.alertmanager.yml`

  ```yaml
  alertmanagerFiles:
    alertmanager.yml:
      global: 
        smtp_smarthost: 'smtp.163.com:25'
        smtp_from: 'xxxx@163.com'
        smtp_auth_username: 'xxxx@163.com'
        smtp_auth_password: '*********'
        smtp_require_tls: false
  
      receivers:
        - name: 'AlertMail'
          email_configs:
          - to: 'xxxx@163.com'
        - name: dingtalk
          webhook_configs:
          - send_resolved: false
            # 需要运行插件 dingtalk-webhook.yaml，详情阅读 docs/guide/prometheus.md
            url: http://webhook-dingtalk.monitoring.svc.cluster.local:8060/dingtalk/webhook1/send
  
      route:
        group_by: ['alertname', 'pod_name']
        group_wait: 10s
        group_interval: 5m
        #receiver: AlertMail
        receiver: dingtalk
        repeat_interval: 3h
  ```

  

- 指定 `serverFiles.alerting_rules.yml`

  ```yaml
  serverFiles:
    alerting_rules.yml: 
      groups:
        - name: k8s_alert_rules
          rules:
            # ALERT when container memory usage exceed 90%
            - alert: container_mem_over_90
              expr: (sum(container_memory_working_set_bytes{image!="",name=~"^k8s_.*", pod_name!=""}) by (pod_name)) / (sum (container_spec_memory_limit_bytes{image!="",name=~"^k8s_.*", pod_name!=""}) by (pod_name)) > 0.9 and (sum(container_memory_working_set_bytes{image!="",name=~"^k8s_.*", pod_name!=""}) by (pod_name)) / (sum (container_spec_memory_limit_bytes{image!="",name=~"^k8s_.*", pod_name!=""}) by (pod_name)) < 2
              for: 2m
              annotations:
                summary: "{{ $labels.pod_name }}'s memory usage alert"
                description: "Memory Usage of Pod {{ $labels.pod_name }} on {{ $labels.kubernetes_io_hostname }} has exceeded 90% for more than 2 minutes."
            # ALERT when node is down
            - alert: node_down
              expr: up == 0
              for: 60s
              annotations:
                summary: "Node {{ $labels.kubernetes_io_hostname }} is down"
              description: "Node {{ $labels.kubernetes_io_hostname }} is down"
  ```
  
  




## 执行

```bash
# 自行添加钉钉机器人，记录webhook地址： https://oapi.dingtalk.com/robot/send?access_token=xxxxxxxx

kubectl create namespace monitoring

# 创建证书secret 证书文件需自行创建
kubectl create secret tls prometheus-ingress-tls -n monitoring --key ~/ssl/tls.key --cert ~/ssl/tls.crt


# V2
helm install --name prometheus --namespace monitoring -f ./files/prometheus.yaml stable/prometheus

# V3

helm install prometheus --namespace monitoring -f ./files/prometheus.yaml stable/prometheus


# 创建钉钉告警插件
sed -i 's/access_token_demo/access_token值/g' ./files/webhook-dingtalk.yaml
# 如果安全设置使用密钥方式
sed -i 's/# secret: secret_demo/secret: secret值/g' ./files/webhook-dingtalk.yaml
kubectl apply -f ./files/webhook-dingtalk.yaml

```

