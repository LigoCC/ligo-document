#### Docker registry跨主机访问 

- 参考

```
https://blog.csdn.net/Jerry00713/article/details/108318950?ops_request_misc=&request_id=&biz_id=102&utm_term=docker%20registery%20http:%20server%20&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduweb~default-5-108318950.142^v93^chatsearchT3_1&spm=1018.2226.3001.4187
```

- 步骤

1.cloud-linux:部署docker、docker-compose,docker安装registry,vim /etc/docker/daemon.json配置"insecure-registries": ["cloud-linux.ip:registry.port"],重启docker

2.dell-linux:部署docker、vim /etc/docker/daemon.json配置"insecure-registries": ["cloud-linux.ip:registry.port"],重启docker

3.推送、拉取镜像
	3.1 docker tag hello-world:latest cloud-linux.ip:registry.port/hello-world:latest
	3.2 docker push cloud-linux.ip:registry.port/hello-world:latest
	3.2 docker pull cloud-linux.ip:registry.port/hello-world:latest

#### docker命令

```
# registry推送、拉取镜像
docker tag hello-world:latest registry.ip:registry.port/hello-world:latest
docker push registry.ip:registry.port/hello-world:latest
docker pull registry.ip:registry.port/hello-world:latest

# dockfile制作镜像
docker build -t 镜像名:版本号 dockerfile文件夹路径
# 当dockerfile在当前目录下时
docker build -t 镜像名:版本号 .

# docker-compose启动
docker-compose up -d

# docker通过load命令加载为镜像
docker load -i mysql.tar
```

