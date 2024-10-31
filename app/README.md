# Задание 3 - создание приложения
 1) Тут все было довольно просто, создаем конфиг nginx, страничку index.html и Dockerfile.  
 Смотреть тут: [https://github.com/SkillPropil/spapp](spapp)  
 2) Далее собираем образ и пушим его в registry (Docker Hub)  
```
docker login -u nixao70@gmail.com -p pwd
docker build -t skillpropil/nginx_static_index:0.0.2 .

[root@skillpropilserv-01 app]# docker push skillpropil/nginx_static_index:0.0.2
The push refers to repository [docker.io/skillpropil/nginx_static_index]
f8e7d3120bc3: Pushed 
0f24ce20b34d: Pushed 
528b47987bcf: Mounted from library/nginx 
a533c9e2e114: Mounted from library/nginx 
6033613561cc: Mounted from library/nginx 
0de02d5b2d31: Mounted from library/nginx 
f80bfdacda57: Mounted from library/nginx 
1241fe31c0bf: Mounted from library/nginx 
4e9e0d6ba2cc: Mounted from library/nginx 
63ca1fbb43ae: Mounted from library/nginx 
0.0.2: digest: sha256:3c10aac9cc541793299e08715b2c105ce3eabeb4e1eefe1585ae38dfb4ce0802 size: 2403

```  
<img width="1470" alt="Docker" src="https://github.com/user-attachments/assets/58ce75bd-bdf4-4328-9aa3-385cdbb4b356">  

 3) Проверим что все работает
```
root@skillpropilserv-01 app]# docker run -d --rm -p 80:80 --name nginx skillpropil/nginx_static_index:0.0.2
5699a1840b51ddb696d7f07853407919f6d5c482e75f1ac8cf5785477474e63a
[root@skillpropilserv-01 app]# curl localhost
<html>
<body>
        <h1>Host: 5699a1840b51</h1>
        Version: 1.1
</body>
</html>
```
