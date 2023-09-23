# docker-cxx-on-ubuntu

## 使用方法

  + 動作確認環境
    + Windows 11 Pro
    + Docker Desktop version 4.9.0 (80466)

### Docker イメージを構築する

```
docker build --tag docker-cxx-on-ubuntu .
```

### Docker コンテナを起動する

```
docker run -it --detach --mount "type=bind,src=$(pwd),target=/opt/docker-cxx-on-ubuntu" --name docker_cxx_on_ubuntu docker-cxx-on-ubuntu
```

  > `--mount` オプションを `--name` オプションの前に記述しないとエラーが発生する点に注意！
  >
  > + エラーメッセージ :
  >
  > ```
  > docker: Error response from daemon: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: exec: "--mount": executable file not found in $PATH: unknown.
  > ```

### Docker コンテナ上で実行中の Ubuntu にログインする

```
docker exec -it docker_cxx_on_ubuntu "/bin/bash"
```

### Docker コンテナを停止する

```
docker rm -f docker_cxx_on_ubuntu
```

### その他

  + (例) Ubuntu にログインし、 C++ のソースコードをコンパイルし、コンパイルされた実行ファイルを実行する

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
