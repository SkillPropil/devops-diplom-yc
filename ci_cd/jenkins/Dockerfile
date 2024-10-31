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
