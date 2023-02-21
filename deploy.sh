#!/bin/bash



LOG="exec.log"
ERROR="error.log"
DATE=$(date +"%d/%m/%Y - %H:%M:%S")

echo "$DATE - Iniciando o processo"

if [ ! -e "$LOG" ]; then
    echo "$DATE - criando arquivo de log" | tee -a "$LOG"
    touch "$LOG"
fi



echo "$DATE - Realizando o build das imagens." | tee -a "$LOG"


docker build -t ricardolnx/dio_backend:1.0 backend/. 2> "$ERROR"

if [ $? -gt 0 ]; then
    echo "$DATE - Erro na criação da imagem, o erro foi regristrado no arquivo $ERROR. Parando processo" | tee -a "$LOG"
    exit 1
fi

echo "continuando..."


# docker build -t ricardolnx/dio_db:1.0 backend/database/.

# echo "Realizando push das imagens...."

# docker push ricardolnx/desafio_backend:1.0 && \
# docker push ricardolnx/desafio_backend_db:1.0 


# echo "Criando serviços no cluster Kubernets...."

# kubectl apply -f ./services.yml

# echo "Criando os deployments....."

# kubectl apply -f ./deployment.yml
