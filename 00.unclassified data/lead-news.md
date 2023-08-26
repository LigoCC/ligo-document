## lead-news项目搭建

#### 1.nacos

- docker部署nacos

```
# docker拉取镜像 
docker pull nacos/nacos-server:1.2.0

# 创建容器
docker run --env MODE=standalone --name nacos --restart=always  -d -p 8848:8848 nacos/nacos-server:1.2.0
```

