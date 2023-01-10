FROM ub-base

ARG USUARIO
ARG PASSWD
ARG PROYECTO
ARG DB_HOST
ARG DB_NAME
ARG DB_PORT
ARG DB_USER
ARG DB_PASS
ARG URL_GIT
ARG W_PORT

ENV USUARIO=${USUARIO}
ENV PASSWD=${PASSWD}
ENV PROYECTO=${PROYECTO}
ENV DB_HOST=${DB_HOST}
ENV DB_NAME=${DB_NAME}
ENV DB_PORT=${DB_PORT}
ENV DB_USER=${DB_USER}
ENV DB_PASS=${DB_PASS}
ENV URL_GIT=${URL_GIT}
ENV W_PORT=${w_PORT}




RUN apt-get update && apt-get install -y -q --no-install-recommends \
    ca-certificates \
    gnupg2 \
    nginx

WORKDIR /root 


COPY ./start-nest.sh /root
COPY ./nginx.conf /root

COPY ./nodesource.list /etc/apt/sources.list.d/
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - 
RUN apt-get update && apt-get install -y nodejs


RUN dos2unix /root/start-nest.sh 
RUN chmod +x /root/start-nest.sh

EXPOSE 80
ENTRYPOINT [ "/root/start-nest.sh" ]