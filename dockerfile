#Imagen docker de prueba.

#Origen: Ubuntu 14.04 LTS
FROM ubuntu:14.04

#Creador:
MAINTAINER Jesus Marin <jam@jam.net.ve>

#Actualizar el repositorio Ubuntu, luego descarga e instala paquetes que
#requieren actualizacion.
RUN apt-get -qq update && apt-get -qqy upgrade

#Instalar algunos paquetes bases, utiles para mi y algunas dependencias.
RUN apt-get -qqy install wget git curl dnsutils tmux zsh openssh-server pwgen vim

#Tomado de https://github.com/tutumcloud/tutum-ubuntu/blob/master/Dockerfile
#Para configurar SSHD y crear una contrasena para usuario ROOT
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22
CMD ["/run.sh"]
