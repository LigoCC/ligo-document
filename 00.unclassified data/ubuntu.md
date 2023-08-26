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

#### 配置内网穿透

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

#### ubuntu命令

```
# 解压文件到指定位置
tar -zxvf  要解压的文件名  -C 要解压到哪个路径下
```

