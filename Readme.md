
# Desafio Deploy Kubernets da DIO

Este é um execicio de um deploy de uma aplicação básica com banco de dados.

Esta aplicação foi implantada em um Cluster na Google Cloud.

# Utilização

Para utilizar este deploy certifique-se de que:

* Você possui o Docker instalado em seu computador;
* Possui acesso a algum Cluster em nuvem ou local;
* Está conectado ao Cluster.

Existe um script para automatizar o processo de deploy. Este script está localizado na raíz do projeto com o nome de deploy.sh.

Ele envia os logs para dois arquivos, exec.log e error.log. Caso tenha algum problema com o deploy, verifique no arquivo error.log.