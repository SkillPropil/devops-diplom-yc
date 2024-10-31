# Второе задание - создание кластера Kubernetes
 1) Склонировал репозиторий в папку с terraform  ``` git clone https://github.com/kubernetes-sigs/kubespray ```
 2) Создал файл inventory.tf и inventory.tpl в предыдущем этапе [inventory.tf](../terraform/inventory.tf)  [inventory.tpl](../terraform/inventory.tpl)  
 3) Запустил ``` terraform apply ``` и в директории создался файл ``` /terraform/kubespray/inventory/mycluster/inventory-default.ini ```  
 4) Установил зависимости kubespray ``` pip3 install -r requirements.txt ```  
 5) Далее запустил плейбук и кластер раскатился  
```
ansible-playbook -i inventory/mycluster/inventory-default.ini cluster.yml -b -v
PLAY RECAP *****************************************************************************************
master-0                   : ok=634  changed=139  unreachable=0    failed=0    skipped=1074 rescued=0    ignored=6   
work-0                     : ok=416  changed=84   unreachable=0    failed=0    skipped=645  rescued=0    ignored=1   
work-1                     : ok=416  changed=84   unreachable=0    failed=0    skipped=641  rescued=

```
Ноды кубера  
<img width="582" alt="ноды кубера" src="https://github.com/user-attachments/assets/df7ac4cd-1025-49ba-bd9e-e4beb4db9766">  

Поды  
<img width="988" alt="Кубер" src="https://github.com/user-attachments/assets/342e4da9-fbf8-487b-a527-fbf0b1107e50">
