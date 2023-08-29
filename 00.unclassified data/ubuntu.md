#### ubuntu系统安装

1.下载[镜像文件](aliyun ubuntu-22.04.2-desktop-amd64)及[软件(UltralSO)](aliyun uiso9_cn)

2.制作启动盘

3.安装系统

#### ubuntu开机操作

1.打开【软件和更新】软件，更换国内源

2.卸载垃圾软件

3.更新软件

4.关闭防火墙

```
# 查看当前防火墙状态
sudo ufw status

# 开启防火墙
sudo ufw enable

# 关闭防火墙
sudo ufw disable
```

5.安装ssh远程连接服务

```
sudo apt-get install openssh-server
```

6.配置必要软件的开机自启动

```
【启动应用程序】软件
```

7.设置每日定时开机、定时关机

```
# 定时开机
开机按F10,设置每日自动开机bios

# 定时关机
sudo vim /etc/crontab
0 0 * * * root /sbin/shutdown now	# 设定定时任务-每日凌晨自动关机
sudo /etc/init.d/cron restart	# 使添加内容生效
```


#### ubuntu系统目录及作用

| 编号 | 目录  | 含义                                       |
| ---- | ----- | ------------------------------------------ |
| 1    | /bin  | 存放二进制可执行文件                       |
| 2    | /boot | 存放系统引导时使用的各种文件               |
| 3    | /dev  | 存放设备文件                               |
| 4    | /etc  | 存放系统配置文件                           |
| 5    | /home | 存放系统用户的文件                         |
| 6    | /lib  | 存放程序运行所需的共享库和内核模块         |
| 7    | /opt  | 额外安装的可选应用程序包所放置的位置       |
| 8    | /root | 超级用户目录                               |
| 9    | /sbin | 存放二进制可执行文件，只有root用户才能访问 |
| 10   | /tmp  | 存放临时文件                               |
| 11   | /usr  | 存放系统应用程序                           |
| 12   | /var  | 存放运行时需要改变数据的文件，例如日志文件 |

#### ubuntu软件安装目录

```
/home/package 目录--->安装包存放位置
/usr/local 目录------>普通软件
/opt 目录------------>一般大型软件或者是一些服务程序安装
```

#### ubuntu目标

1.内网穿透、远程控制

2.部署一个项目运行

#### ubuntu配置内网穿透

1.[下载frp](aliyun frp_0.33.0_linux_amd64)

2.云服务器开放端口，并安装frp，配置frps，并启动服务、配置开机自启动

```
# 解压frp压缩包
tar -zxvf frp_0.33.0_linux_amd64.tar.gz

# 进入该解压目录
cd frp_0.33.0_linux_amd64/

# 打开服务端配置文件
vi frps.ini

# 配置文件配置以下内容
```

```
[common]
# frp监听的端口，默认是7000，可以改成其他的
bind_port = 7000
# 授权码，请改成更复杂的
token = 52010  # 这个token之后在客户端会用到

# frp管理后台端口，请按自己需求更改
dashboard_port = 7500
# frp管理后台用户名和密码，请改成自己的
dashboard_user = admin
dashboard_pwd = admin
enable_prometheus = true

# frp日志配置
log_file = /var/log/frps.log
log_level = info
log_max_days = 3
```

```
# 防火墙开放端口(云服务器直接在管理控制台开启相关端口)

# 设置和启动frp服务
sudo mkdir -p /etc/frp
sudo cp frps.ini /etc/frp
sudo cp frps /usr/bin
sudo cp systemd/frps.service /usr/lib/systemd/system/
sudo systemctl enable frps	# 开机自启动
sudo systemctl start frps	# 启动frps

# 验证服务端是否启动成功
访问：http://服务器IP:后台管理端口，输入用户名和密码查看连接状态
```

3.ubuntu安装frp，配置frpc，并启动服务、配置开机自启动

```
# 解压frp压缩包
tar -zxvf frp_0.33.0_linux_amd64.tar.gz

#进入解压目录
cd frp_0.33.0_linux_amd64/

# 打开配置文件(注意哦，不是frps.ini)
vi frpc.ini

# 配置文件配置以下内容
```

```
# 客户端配置
[common]
server_addr = 服务器ip
 # 与frps.ini的bind_port一致
server_port = 7000
 # 与frps.ini的token一致
token = 52010

# 配置ssh服务
[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 22
 # 这个自定义，之后再ssh连接的时候要用
remote_port = 6000 

# 配置http服务，可用于小程序开发、远程调试等，如果没有可以不写下面的
[web]
type = http
local_ip = 127.0.0.1
local_port = 8080
# web域名
subdomain = test.hijk.pw
# 自定义的远程服务器端口，例如8080
remote_port = 8080
```

```
# 防火墙开放端口

# 设置和启动frp服务
sudo mkdir -p /etc/frp
sudo cp frpc.ini /etc/frp
sudo cp frpc /usr/bin
sudo cp systemd/frpc.service /usr/lib/systemd/system/
sudo systemctl enable frpc	# 开机自启动
sudo systemctl start frpc	# 启动frpc
```

##### 修改配置重启frpc生效

```
# 新增端口映射后，重启frpc.ini
sudo rm /etc/frp/frpc.ini
sudo cp frpc.ini /etc/frp
sudo systemctl restart frpc
```

#### ubuntu安装docker

1.安装docker

```
# 先卸载旧版
sudo apt-get remove docker docker-engine docker.io containerd runc

# 更新及安装工具软件
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release

# 安装证书
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -

# 写入软件源信息
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

# 安装
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# 启动docker
sudo systemctl start docker

# 安装工具
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common

# 重启docker
sudo service docker restart

# 查看docker版本 
docker version

# 查看镜像
docker images

# 将当前用户加入docker组
sudo groupadd docker	# 添加docker用户组
sudo gpasswd -a $USER docker	# 将用户加入到docker用户组
newgrp docker	# 更新用户组
```

2.关闭防火墙

3.启动docker

4.配置docker镜像加速器

```
# 通过修改daemon配置文件/etc/docker/daemon.json来使用加速器
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://tadg75bn.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

~~5.配置docker开机自启动~~

6.安装docker compose

- [docker-compose](aliyun docker-compose)上传到/usr/local/bin/

- 修改文件权限 

  ```
  chmod +x /usr/local/bin/docker-compose
  ```

- Base自动补全命令

  ```
  # 补全命令
  curl -L https://raw.githubusercontent.com/docker/compose/1.29.1/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
  
  # 如果这里出现错误，需要修改自己的hosts文件：
  echo "199.232.68.133 raw.githubusercontent.com" >> /etc/hosts
  ```

#### ubuntu安装nginx

- 上传[nginx-1.16.1.tar.gz](aliyun nginx-1.16.1.tar.gz)到计算机

- 安装

  ```
  # 解压安装包
  tar -xvf nginx-1.16.1.tar.gz -C /usr/local/
  
  # 进入nginx目录
  cd /usr/local/nginx-1.16.1
  
  # 执行命令
  ./configure
  
  # 执行make命令
  sudo make
  
  # 执行make install命令
  sudo make install
  ```

- 启动

  ```
  # 启动nginx
  /usr/local/nginx/sbin/nginx -v
  sudo /usr/local/nginx/sbin/nginx
  
  # 默认端口号:80
  ```

- 配置开机自启动

  ```
  # 编辑rc.local.service
  cd /lib/systemd/system/
  vim rc.local.service
  # 添加以下配置，保存
  >>>>>>
  #  This file is part of systemd.
  #
  #  systemd is free software; you can redistribute it and/or modify it
  #  under the terms of the GNU Lesser General Public License as published by
  #  the Free Software Foundation; either version 2.1 of the License, or
  #  (at your option) any later version.
  
  # This unit gets pulled automatically into multi-user.target by
  # systemd-rc-local-generator if /etc/rc.local is executable.
  [Unit]
  Description=/etc/rc.local Compatibility
  ConditionFileIsExecutable=/etc/rc.local
  After=network.target
  
  [Service]
  Type=forking
  ExecStart=/etc/rc.local start
  TimeoutSec=0
  RemainAfterExit=yes
  
  #以下为添加的配置
  [Install]
  WantedBy=multi-user.target
  Alias=rc-local.service
  <<<<<<
  
  # 设置软连接，开机启动查找 /etc/……文件
  sudo ln -s /lib/systemd/system/rc.local.service /etc/systemd/system/rc.local.service
  
  # 修改rc.local
  vim /etc/rc.local
  # 添加如下配置
  >>>>>>
  #!/bin/sh -e
  #
  # rc.local
  #
  # This script is executed at the end of each multiuser runlevel.
  # Make sure that the script will "exit 0" on success or any other
  # value on error.
  #
  # In order to enable or disable this script just change the execution
  # bits.
  #
  # By default this script does nothing.
  sudo -S /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf << EOF
  root 你的密码
  EOF
  exit 0
  <<<<<<
  
  # 修改权限
  sudo chmod +x rc.local
  # 重启
  sudo reboot now
  ```

#### ubuntu命令

```
# 解压文件到指定位置
tar -zxvf  要解压的文件名  -C 要解压到哪个路径下

# 复制，如果文件存在直接覆盖并且不提示
cp -nrf testDir destDir

# 制作可执行文件[Install.sh]并执行
sudo chmod u+x Install.sh	# 赋予该文件权限
sudo ./Install.sh	# 运行该文件
```

