# LinuxTips-Giropops-Senhas-Chainguard
Desafio da LinuxTips de construir uma imagem do Giropops senhas usando a imagem Python da Chainguard e com o mínimo de vunerabilidades. Curso **Descomplicando o Docker** da [LinuxTips](https://www.linuxtips.io/course/descomplicando-docker).


## Dockerfile

No diretório Dockerfile tem um arquivo *dockerfile* que cria a imagem com o app **Giropops-Senhas**.

---

<br> 

### Criação de uma rede em comum entre os containers 

A rede foi criada para o acesso entre os containers via **Hostname**.
```shell
docker network create --driver bridge rede_containers
```
<br>

### Execução do container Redis

Executa o container Redis com o **Nome** e **Hostname** igual a *redis*. 
```shell
docker container run -d --net rede_containers --name redis --hostname redis redis:7.4-alpine3.20
```

<br>

### Execução do container do APP Giropops-Senhas

Executa o container do APP Giropops-Senhas e o acesso ao APP é pelo navegador na porta 5000.
```shell
docker container run -d --net rede_containers --name giropops-senhas -p 5000:5000 ferpdias/linuxtips-giropops-senhas-chainguard:1.0
```

<br>

--- 