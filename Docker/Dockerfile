FROM --platform=linux/amd64 ubuntu:20.04

COPY ./dana ./home/nashid/dana
COPY ./emergent_web_server ./home/nashid/emergent_web_server
ENV DANA_HOME=/home/nashid/dana/
ENV PATH="${PATH}:/home/nashid/dana/"
WORKDIR /home/nashid/emergent_web_server/pal/

ENTRYPOINT ["/bin/bash", "./../Docker/emergentsys.sh"]