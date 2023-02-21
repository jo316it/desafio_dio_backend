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


docker build -t ricardolnx/dio_db:1.0 backend/database/.

if [ $? -gt 0 ]; then
    echo "$DATE - Erro na criação da imagem, o erro foi regristrado no arquivo $ERROR. Parando processo" | tee -a "$LOG"
    exit 1
fi

echo "$DATE - Realizando push das imagens." | tee -a "$LOG"

docker push ricardolnx/desafio_backend:1.0 2> "$ERROR"

if [ $? -gt 0 ]; then
    echo "$DATE - Erro na criação da imagem, o erro foi regristrado no arquivo $ERROR. Parando processo" | tee -a "$LOG"
    exit 1
fi

docker push ricardolnx/desafio_backend_db:1.0 2> "$ERROR"

if [ $? -gt 0 ]; then
    echo "$DATE - Erro na criação da imagem, o erro foi regristrado no arquivo $ERROR. Parando processo" | tee -a "$LOG"
    exit 1
fi

echo "$DATE - Imagens foram lançadas do Docker Hub com sucesso. Vamos fazer o deploy da aplicação. Certifique-se de que seu cluster ja esteja conectado" | tee -a "$LOG"

sleep 2

echo "$DATE - Criando serviços no cluster Kubernets."

kubectl apply -f ./services.yml

if [ $? -gt 0 ]; then
    echo "$DATE - Erro na criação do serviço, o erro foi regristrado no arquivo $ERROR. Parando processo" | tee -a "$LOG"
    exit 1
fi

echo "$DATE - Serviço criado com sucesso. Realizando deploy." | tee -a "$LOG"

kubectl apply -f ./deployment.yml

if [ $? -gt 0 ]; then
    echo "$DATE - Erro na criação do serviço, o erro foi regristrado no arquivo $ERROR. Parando processo" | tee -a "$LOG"
    exit 1
fi

echo "$DATE - Deploy criado com sucesso. Processo finalziado, verique no Cluster se está tudo Ok" | tee -a "$LOG"
