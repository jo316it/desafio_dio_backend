FROM php:7.4-apache-alpine

# Copia os arquivos PHP para o diretório padrão do Apache
COPY index.php /var/www/html/
COPY conexao.php /var/www/html/

# Porta do Apache
EXPOSE 80

# Inicia o Apache quando o container for iniciado
CMD ["httpd", "-D", "FOREGROUND"]
