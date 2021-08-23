FROM mtulio/jupyter-lab:latest

ENV NB_USER=splat
ENV PWD=${PWD}

WORKDIR /home/$NB_USER
VOLUME ["$PWD/:/home/$NB_USER/repo"]
VOLUME ["$PWD/notebooks:/home/$NB_USER/notebooks"]

COPY ./requirements.txt ./requirements.txt
RUN pip install -r ./requirements.txt

EXPOSE 8888/tcp
