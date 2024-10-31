# Этап 4 - мониторинг и деплой приложения
## Мониторинг
 1) Клонируем репозиторий ``` https://github.com/prometheus-operator/kube-prometheus ```
 2) Удаляем файл ``` grafana-networkPolicy.yaml ``` и правим ``` grafana-service.yaml ``` на:
    ```
---
apiVersion: v1
  kind: Service
  metadata:
    labels:
      app.kubernetes.io/component: grafana
      app.kubernetes.io/name: grafana
      app.kubernetes.io/part-of: kube-prometheus
      app.kubernetes.io/version: 11.2.0
    name: grafana
    namespace: monitoring
  spec:
    ports:
    - name: http
      port: 3000
      targetPort: http
      nodePort: 30000
    selector:
      app.kubernetes.io/component: grafana
      app.kubernetes.io/name: grafana
      app.kubernetes.io/part-of: kube-prometheus
    type: NodePort
    ```  
 3) Далее применяем все это дело:  
 ```
 kubectl apply --server-side -f /home/ubuntu/monitoring_kubernetes/manifests/setup -f /home/ubuntu/monitoring_kubernetes/manifests
 ```
Наслаждаемся мониторингом. 

<img width="1321" alt="Снимок экрана 2024-11-01 в 01 05 11" src="https://github.com/user-attachments/assets/210138d5-c721-42d4-9fb7-85f2d9efa7cf">  
<img width="1469" alt="grafana-kube" src="https://github.com/user-attachments/assets/397ba437-571d-4e92-8ec9-cc53487f0146">

## Деплой приложения
 1) Чтобы задеплоить приложение я использовал helm  
```
helm create static-nginx
Creating static-nginx
```  
 2) Почистил все лишние файлы и загрузил конфигурации
### static-nginx.yaml
```
#static-nginx.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: "{{.Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: IfNotPresent
          ports:
---
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  type: NodePort
  ports:
  - port: {{ .Values.service.port }}
    nodePort: {{ .Values.service.nodePort }}
  selector:
    app: nginx
---
```
### values.yaml
```
#values.yaml
replicaCount: 1
image:
  repository: skillpropil/nginx_static_index
  tag: "latest"
service:
  type: NodePort
  port: 80
  nodePort: 30001
```
 3) Применяем конфигурацию:
```
root@master-0:~# helm install static-nginx static-nginx
NAME: static-nginx
LAST DEPLOYED: Wed Oct 30 18:33:42 2024
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
```
 4) Наблюдаем успешно задеплоеное приложение:
 <img width="878" alt="app" src="https://github.com/user-attachments/assets/f4c5d3ca-1043-4b0c-a5a9-2dfbf4049d23">
