#!/bin/bash

echo; echo "AGUARDE A INSTALACAO DO S3"
yum update -y
clear; echo; echo "AGUARDE A INSTALACAO DO S3"; sleep 3
yum install wget gcc libstdc++-deve1 gcc-c++ fuse fuse-devel curl-devel libxml2-devel openssl-devel mailcap make -y
clear; echo; echo "AGUARDE A INSTALACAO DO S3"; sleep 3
mkdir /root/app-s3fs
clear; echo; echo "AGUARDE A INSTALACAO DO S3"; sleep 3
cd /root/app-s3fs
clear; echo; echo "AGUARDE A INSTALACAO DO S3"; sleep 3
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/s3fs/s3fs-1.61.tar.gz
clear; echo; echo "AGUARDE A INSTALACAO DO S3"; sleep 3
tar -xzvf s3fs-1.61.tar.gz
cd /root/app-s3fs/s3fs-1.61; sleep 3
./configure --prefix=/usr
clear; echo; echo "AGUARDE A INSTALACAO DO S3"; sleep 3
make
clear; echo; echo "AGUARDE A INSTALACAO DO S3"; sleep 3
make install
clear; echo; echo "AGUARDE A INSTALACAO DO S3"; sleep 3

touch /root/.passwd-s3fs
echo ID-chave-de-acesso:Chave-acesso-secreta > /root/.passwd-s3fs
clear
echo
echo "ADICIONE o ID da CHAVE DE ACESSO DO USUARIO IAM"
echo "E ADICIONE A CHAVE DE ACESSO SECRETA DO USUARIO IAM"
echo
read -p "ID da chave de acesso: " idchave; echo
read -p "Chave de acesso secreta: " chavesecret; echo

sed -i 's/ID-chave-de-acesso/'$idchave'/' /root/.passwd-s3fs
sed -i 's/Chave-acesso-secreta/'$chavesecret'/' /root/.passwd-s3fs
chmod 600 /root/.passwd-s3fs
clear; echo; echo "CONFIRA ABAIXO O ID da CHAVE DE ACESSO E A CHAVE DE ACESSO SECRETA DO USUARIO IAM"
echo
cat /root/.passwd-s3fs
sleep 10

clear
echo
echo "DIGITE O NOME DO BUCKET E DEFINA O LOCAL PARA MONTAR O BUCKET S3"
echo
echo "Exempo: buckets3"
read -p "Nome do bucket S3: " names3; echo
echo "Exempo: /root/bucket"
read -p "Local onde será montado o bucket S3: " locals3; echo

mkdir $locals3
/usr/bin/s3fs $names3 $locals3
clear; echo; echo "O SEU BUCKET S3 ESTA MONTADO EM: $locals3 "; echo
