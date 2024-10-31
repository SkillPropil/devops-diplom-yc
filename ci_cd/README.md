# Задание пятое (ФИНАЛ). Конфигурация CI-CD
## Установка системы
 1) Для начала нужно было выбрать и установить систему. Мой выбор встал на Jenkins, так как по нему море документации, примеров и у него тысяча плагинов.
 2) Установку Jenkins я выполнял при помощи собственного образа и деплоймента. [jenkins/Dockerfile](Dockerfile)
```
FROM jenkins/jenkins:lts
# Устанавливаем необходимые пакеты
USER root
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*
# Устанавливаем kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && kubectl version --client
# Устанавливаем Docker CLI
RUN apt-get update && apt-get install -y \
    docker.io \
    && rm -rf /var/lib/apt/lists/*
# Устанавливаем плагины Jenkins
RUN jenkins-plugin-cli --plugins \
    docker-workflow:latest \
    kubernetes-cli:latest \
    workflow-aggregator:latest \
    git:latest
# Возвращаемся к пользователю Jenkins
USER jenkins
# Expose default Jenkins port
EXPOSE 8080
```  
 3) После создания докерфайла он был запушен в мой репозиторий на DockerHub [https://hub.docker.com/repository/docker/skillpropil/spjenkins/general](репа)  
 4) Далее зашел на мастер-ноду и создал деплоймент с сервисом  
### deployment.yaml  
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins
  namespace: jenkins
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jenkins
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      securityContext:
        fsGroup: 1000 # Jenkins group (1000) read/write access to volumes.

      initContainers:
      - name: volume-mount-hack
        image: busybox
        command: 
          - sh
          - "-c"
          - |
            chown -R 1000:1000 /var/jenkins_home
        volumeMounts:
        - name: jenkins-home
          mountPath: /var/jenkins_home
  

      containers:

      - name: jenkins
        image: skillpropil/spjenkins:v2
        ports:
        - containerPort: 8080
        volumeMounts:
        - name: jenkins-home
          mountPath: /var/jenkins_home


        env:
        - name: JAVA_OPTS
          value: "-Djenkins.install.runSetupWizard=false"
        - name: DOCKER_HOST
          value: tcp://localhost:2375

      - name: dind
        image: "docker:dind"
        imagePullPolicy: Always
        command: ["dockerd", "--host", "tcp://127.0.0.1:2375"]
        securityContext:
          privileged: true
        volumeMounts:
          - name: launcher-storage
            mountPath: /var/lib/docker
            subPath: docker

      volumes:
      - name: jenkins-home
        emptyDir: { }
      - name: launcher-storage
        emptyDir: {}
      - name: jenkins-credentials
```  
### service.yaml
```
---
apiVersion: v1
kind: Service
metadata:
  name: jenkins-public
  namespace: jenkins
spec:
  type: NodePort
  ports:
  - name: jenkins-public
    port: 8080
    nodePort: 32000
  selector:
    app: jenkins
```  
 5) Делаем ``` kubectl apply -f deployment.yaml service.yaml ```
<img width="1272" alt="jenkins" src="https://github.com/user-attachments/assets/dbe1f39e-b688-4c8e-80bc-31b291582aab">  
 6) Чтобы работали пайпы создаем сервисный аккаунт jenkins и назначаем ему роль  
```
kubectl create sa jenkins
kubectl create clusterrolebinding cesar3 \
  --clusterrole=cluster-admin \
  --user=system:serviceaccount:jenkins:default \
  --group=certificates.k8s.io
clusterrolebinding.rbac.authorization.k8s.io/cesar3 created
```  
## Пайплайны
### Пайп1
 1) Создал репу и загрузил туда свое приложение [https://github.com/SkillPropil/spapp](Приложение)  
 2) Создал пайп, чтобы при любом коммите происходила сборка и пуш в докер реджистри [https://github.com/SkillPropil/spapp/blob/main/Jenkinsfile](Jenkinsfile)  
 3) А также добавил хук. Успешный запуск на скринах
    <img width="1262" alt="hook" src="https://github.com/user-attachments/assets/6b8bd424-ba8f-4423-a364-4d6c5d72dcc4">  
    <img width="1313" alt="Снимок экрана 2024-11-01 в 01 41 21" src="https://github.com/user-attachments/assets/fb37482b-b495-48af-b243-459cb84b9c13">  
### Пайп2 
 1) Создал пайп, чтобы при любом коммите происходила сборка и пуш в докер реджистри [https://github.com/SkillPropil/spapp/blob/main/Pipelinefile](Pipelinefile)  
 2) Пайп отличается тем, что если пушить без тега - образ не будет задеплоен. Поэтому можно было бы обойтись и без первого пайпа.
<img width="1372" alt="Снимок экрана 2024-10-31 в 22 57 57" src="https://github.com/user-attachments/assets/44c1aa19-3f26-422e-a89d-530e251f30ed">  
<img width="1261" alt="Снимок экрана 2024-11-01 в 01 21 08" src="https://github.com/user-attachments/assets/23fdedb8-bcc5-4d3f-ab87-1eeccdacda86">  
<img width="1314" alt="Снимок экрана 2024-10-31 в 22 58 20" src="https://github.com/user-attachments/assets/a405db30-e22d-4d8e-af7a-7c5e56751f81">  


