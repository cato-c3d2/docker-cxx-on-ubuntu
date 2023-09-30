# Docker C++ on Ubuntu

## 環境

### 動作確認環境

  + Windows 11 Pro バージョン 22H2
  + Docker :

```
PS C:\Work\Space\docker-cxx-on-ubuntu> docker version
Client:
 Cloud integration: v1.0.35+desktop.4
 Version:           24.0.6
 API version:       1.43
 Go version:        go1.20.7
 Git commit:        ed223bc
 Built:             Mon Sep  4 12:32:48 2023
 OS/Arch:           windows/amd64
 Context:           default

Server: Docker Desktop 4.23.0 (120376)
 Engine:
  Version:          24.0.6
  API version:      1.43 (minimum version 1.12)
  Go version:       go1.20.7
  Git commit:       1a79695
  Built:            Mon Sep  4 12:32:16 2023
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.22
  GitCommit:        8165feabfdfe38c65b599c4993d227328c231fca
 runc:
  Version:          1.1.8
  GitCommit:        v1.1.8-0-g82f18fe
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
PS C:\Work\Space\docker-cxx-on-ubuntu>
```

## 使用方法

### Docker Compose を使用する場合

#### コンテナを構築、作成、起動、アタッチする

```
docker-compose up --detach --build
```

#### Docker コンテナ上で実行中の Ubuntu にログインする

```
docker exec -it docker-cxx-on-ubuntu-ubuntu-1 "/bin/bash"
```

#### コンテナを停止し、 `docker-compose up` で作成したコンテナ、ネットワーク、ボリューム、イメージを削除する

```
docker-compose down
```

### Docker Compose を使用しない場合

#### Docker イメージを構築する

```
docker build --tag docker-cxx-on-ubuntu .
```

#### Docker コンテナを起動する

```
docker run -it --detach --name docker_cxx_on_ubuntu --mount "type=bind,src=$(pwd),target=/opt/docker-cxx-on-ubuntu" docker-cxx-on-ubuntu
```

  > 起動する Docker コンテナの指定を最後（オプションの前）に記述しないとエラーが発生する点に注意！
  >
  > + エラーメッセージ :
  >
  > ```
  > docker: Error response from daemon: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: exec: "--mount": executable file not found in $PATH: unknown.
  > ```

#### Docker コンテナ上で実行中の Ubuntu にログインする

```
docker exec -it docker_cxx_on_ubuntu "/bin/bash"
```

#### Docker コンテナを停止する

```
docker rm -f docker_cxx_on_ubuntu
```

### C++ のコンパイルと実行

  + Ubuntu にログインし、 C++ のソースコードをコンパイルし、コンパイルされた実行ファイルを実行する例 :

```
PS C:\Work\Space\docker-cxx-on-ubuntu> docker exec -it docker_cxx_on_ubuntu "/bin/bash"
root@a3d0e913c76b:/opt/docker-cxx-on-ubuntu# ll
total 36
drwxr-xr-x 1 root root 4096 Sep 23 10:49 ./
drwxr-xr-x 1 root root 4096 Sep 23 10:49 ../
drwxr-xr-x 7 root root 4096 Sep 23 10:38 .git/
-rwxr-xr-x 1 root root  270 Sep 23 10:25 .gitignore*
-rwxr-xr-x 1 root root  128 Sep 23 10:41 Dockerfile*
-rwxr-xr-x 1 root root 1066 Sep 23 10:25 LICENSE*
-rwxr-xr-x 1 root root  255 Sep 23 10:40 README.md*
drwxr-xr-x 2 root root 4096 Sep 23 10:49 source/
root@a3d0e913c76b:/opt/docker-cxx-on-ubuntu# cd source/
root@a3d0e913c76b:/opt/docker-cxx-on-ubuntu/source# ll
total 12
drwxr-xr-x 2 root root 4096 Sep 23 10:49 ./
drwxr-xr-x 1 root root 4096 Sep 23 10:49 ../
-rwxr-xr-x 1 root root  101 Sep 23 10:47 hello.c++*
root@d88139d4d6f2:/opt/docker-cxx-on-ubuntu/source# cat hello.c++
#include <iostream>

auto main() -> int
{
    std::cout << "Hello, C++ on Ubuntu on Docker!" << std::endl;
}
root@a3d0e913c76b:/opt/docker-cxx-on-ubuntu/source# # C++ のソースコードをコンパイルする
root@a3d0e913c76b:/opt/docker-cxx-on-ubuntu/source# g++ hello.c++ -Wall
root@a3d0e913c76b:/opt/docker-cxx-on-ubuntu/source# ll
total 36
drwxr-xr-x 1 root root  4096 Sep 23 10:54 ./
drwxr-xr-x 1 root root  4096 Sep 23 10:49 ../
-rwxr-xr-x 1 root root 16528 Sep 23 10:54 a.out*
-rwxr-xr-x 1 root root   101 Sep 23 10:47 hello.c++*
root@a3d0e913c76b:/opt/docker-cxx-on-ubuntu/source# # コンパイルされた実行ファイルを実行する
root@a3d0e913c76b:/opt/docker-cxx-on-ubuntu/source# ./a.out
Hello, C++ on Ubuntu on Docker!
root@a3d0e913c76b:/opt/docker-cxx-on-ubuntu/source#
```

--------------------------------------------------------------------------------

## References

  + Docker ドキュメント日本語化プロジェクト — Docker-docs-ja 24.0 ドキュメント
    + https://docs.docker.jp/index.html
