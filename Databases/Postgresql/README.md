# Postgresql

## links
- [官网](https://www.postgresql.org/)

## 安装
```bash
➜  ~ sudo apt-get install postgresql-10
```

## 配置
```bash
➜  ~ sudo vim /etc/postgresql/10/main/pg_hba.conf 
```

```profile
# "local" is for Unix domain socket connections only
local   all             all                                     md5
```


