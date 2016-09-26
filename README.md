### 定时跟新/etc/hosts
定时跟新/etc/hosts，翻墙，hosts是来自 https://github.com/racaljk/hosts
脚本很简单，hosts=hosts.own+hosts.github (自己本地的hosts+github同步过来的hosts),所以如果需要添加本地hosts，就加载hosts.own然后执行脚本就可以了

#### 定时执行脚本
```
# (change hosts,every 3 hour)
* */3 * * * /home/fenlon/shell/crontab/change_hosts/change_hosts.sh >> /dev/null
```

用crontab来执行定时脚本
因为脚本需要使用root权限执行，所以github中应该有root用户的公钥

```
注意：在ubuntu 14.04下用 sudo crontab -u root xxx ， 设置的表达式无效会按着每分钟执行
      只有 sudo -s 用root 用户，然后使用 crintab -e 来编辑就可以了
```
