# LinuxTips-Giropops-Senhas-Chainguard
Desafio da LinuxTips de construir uma imagem do Giropops senhas usando a imagem Python da Chainguard e com o mínimo de vunerabilidades.


Curso **Descomplicando o Docker** da [LinuxTips](https://www.linuxtips.io/course/descomplicando-docker).


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

Executa o container do APP Giropops-Senhas-Chainguard e o acesso ao APP é pelo navegador na porta 5000.
```shell
docker container run -d --net rede_containers --name giropops-senhas-chainguard -p 5000:5000 ferpdias/linuxtips-giropops-senhas-chainguard:1.0
```

<br>

--- 

### Detecção de vulnerabilidades com o Trivy

Verifica vunerabilidades na imagem com o Trivy
```shell
trivy image ferpdias/linuxtips-giropops-senhas-chainguard:1.0
```
<br>

--- 
```
 trivy image ferpdias/linuxtips-giropops-senhas-chainguard:1.0
2024-08-28T16:35:04-03:00	INFO	[db] Need to update DB
2024-08-28T16:35:04-03:00	INFO	[db] Downloading DB...	repository="ghcr.io/aquasecurity/trivy-db:2"
52.44 MiB / 52.44 MiB [--------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 8.53 MiB p/s 6.3s
2024-08-28T16:35:11-03:00	INFO	[vuln] Vulnerability scanning is enabled
2024-08-28T16:35:11-03:00	INFO	[secret] Secret scanning is enabled
2024-08-28T16:35:11-03:00	INFO	[secret] If your scanning is slow, please try '--scanners vuln' to disable secret scanning
2024-08-28T16:35:11-03:00	INFO	[secret] Please see also https://aquasecurity.github.io/trivy/v0.54/docs/scanner/secret#recommendation for faster secret detection
2024-08-28T16:35:12-03:00	INFO	[python] License acquired from METADATA classifiers may be subject to additional terms	name="MarkupSafe" version="2.1.5"
2024-08-28T16:35:12-03:00	INFO	[python] License acquired from METADATA classifiers may be subject to additional terms	name="click" version="8.1.7"
2024-08-28T16:35:12-03:00	INFO	[python] License acquired from METADATA classifiers may be subject to additional terms	name="pip" version="24.2"
2024-08-28T16:35:12-03:00	INFO	[python] License acquired from METADATA classifiers may be subject to additional terms	name="prometheus-client" version="0.16.0"
2024-08-28T16:35:12-03:00	INFO	[python] License acquired from METADATA classifiers may be subject to additional terms	name="redis" version="4.5.4"
2024-08-28T16:35:12-03:00	INFO	Detected OS	family="wolfi" version="20230201"
2024-08-28T16:35:12-03:00	INFO	[wolfi] Detecting vulnerabilities...	pkg_num=25
2024-08-28T16:35:12-03:00	INFO	Number of language-specific files	num=1
2024-08-28T16:35:12-03:00	INFO	[python-pkg] Detecting vulnerabilities...

ferpdias/linuxtips-giropops-senhas-chainguard:1.0 (wolfi 20230201)

Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)
``´


